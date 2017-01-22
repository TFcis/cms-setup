<?php
$shortservice = array(
	"l" => "LogService",
	"rs" => "ResourceService",
	"s" => "ScoringService",
	"c" => "Checker",
	"e" => "EvaluationService",
	"w" => "Worker",
	"cw" => "ContestWebServer",
	"aw" => "AdminWebServer",
	"proxy" => "ProxyService",
	"print" => "PrintingService",
	"tfc" => "TestFileCacher"
);
$portlist = array(
	"LogService"        => 29000,
	"ResourceService"   => 28000,
	"ScoringService"    => 28500,
	"Checker"           => 22000,
	"EvaluationService" => 25000,
	"Worker"            => 26000,
	"ContestWebServer"  => 21000,
	"AdminWebServer"    => 21100,
	"ProxyService"      => 28600,
	"PrintingService"   => 25123,
	"TestFileCacher"    => 27501
);
$origin_string = array(
	"LogService"        => '["localhost", 29000]',
	"ResourceService"   => '["localhost", 28000]',
	"ScoringService"    => '["localhost", 28500]',
	"Checker"           => '["localhost", 22000]',
	"EvaluationService" => '["localhost", 25000]',
	"Worker"            => '["localhost", 26000],'."\n".
'                              ["localhost", 26001],'."\n".
'                              ["localhost", 26002],'."\n".
'                              ["localhost", 26003]',
	"ContestWebServer"  => '["localhost", 21000]',
	"AdminWebServer"    => '["localhost", 21100]',
	"ProxyService"      => '["localhost", 28600]',
	"PrintingService"   => '["localhost", 25123]',
	"TestFileCacher"    => '["localhost", 27501]'
);
function getservices() {
	$services = file_get_contents("services.json");
	$services = json_decode($services, true);
	return $services;
}
function putservices($services) {
	$services = json_encode($services, JSON_NUMERIC_CHECK |JSON_PRETTY_PRINT);
	$services = str_replace("[\n            ", "[", $services);
	$services = str_replace(",\n            ", ",", $services);
	$services = str_replace("\n        ]", "]", $services);
	file_put_contents("services.json", $services);
}
function make() {
	$services = getservices();
	$conf = file_get_contents("cms.example.conf");
	global $origin_string, $portlist;
	foreach ($portlist as $servicename => $port) {
		$new_string_arr = array();
		foreach ($services[$servicename] as $ip) {
			$temp = array();
			for ($i=0; $i < $ip[1]; $i++) { 
				$temp[]= '["'.$ip[0].'", '.($portlist[$servicename]+$i).']';
			}
			$new_string_arr[]= implode(", ", $temp);
		}
		$new_string = implode(",\n                              ", $new_string_arr);
		$conf = str_replace($origin_string[$servicename], $new_string, $conf);
	}
	file_put_contents("cms.conf", $conf);
}
function show() {
	$services = getservices();
	global $portlist;
	foreach ($portlist as $servicename => $temp) {
		echo $servicename.":";
		foreach ($services[$servicename] as $key => $ip) {
			if ($key%4 == 0) {
				echo "\n";
			}
			echo "  ".$ip[0]." (".$ip[1].")";
		}
		echo "\n";
	}
}
function showthis($ip) {
	$services = getservices();
	global $portlist;
	foreach ($portlist as $servicename => $temp) {
		echo $servicename.": ";
		$index = checkipexist($servicename, $ip);
		if ($index === false) {
			echo "0\n";
		} else {
			echo $services[$servicename][$index][1]."\n";
		}
	}
}
function getip() {
	global $_GET;
	if (!isset($_GET["ip"])) {
		exit("[ERROR] No IP\n");
	}
	if (preg_match("/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/", $_GET["ip"])==0) {
		exit("[ERROR] Format\n");
	}
	return $_GET["ip"];
}
function checkipexist($service, $ip) {
	$services = getservices();
	foreach ($services[$service] as $key => $temp) {
		if ($temp[0] == $ip) {
			return $key;
		}
	}
	return false;
}
function getippresum($service, $ip) {
	$services = getservices();
	$sum = 0;
	foreach ($services[$service] as $key => $temp) {
		if ($temp[0] == $ip) {
			return $sum;
		}
		$sum += $temp[1];
	}
	return false;
}
if (isset($_GET["make"])) {
	make();
}
if (isset($_GET["show"])) {
	show();
}
if (isset($_GET["showthis"])) {
	$ip = getip();
	showthis($ip);
}
if (isset($_GET["getstart"])) {
	$ip = getip();
	$service = "Worker";
	if (in_array($_GET["start"], $shortservice)) {
		$service = $_GET["start"];
	} else if (isset($shortservice[$_GET["start"]])) {
		$service = $shortservice[$_GET["start"]];
	} else if ($_GET["start"] != "") {
		exit("[ERROR] Wrong service\n");
	}
	$sum = getippresum($service, $ip);
	if ($sum === false) {
		echo "-1";
	} else {
		echo $sum;
	}
}
if (isset($_GET["getcount"])) {
	$ip = getip();
	$service = "Worker";
	if (in_array($_GET["count"], $shortservice)) {
		$service = $_GET["count"];
	} else if (isset($shortservice[$_GET["count"]])) {
		$service = $shortservice[$_GET["count"]];
	} else if ($_GET["count"] != "") {
		exit("[ERROR] Wrong service\n");
	}
	$index = checkipexist($service, $ip);
	if ($index === false) {
		echo "0";
	} else {
		$services = getservices();
		echo $services[$service][$index][1];
	}
}
if (isset($_GET["setservice"])) {
	$ip = getip();
	$service = "Worker";
	if (in_array($_GET["service"], $shortservice)) {
		$service = $_GET["service"];
	} else if (isset($shortservice[$_GET["service"]])) {
		$service = $shortservice[$_GET["service"]];
	} else if ($_GET["service"] != "") {
		exit("[ERROR] Wrong service: ".$_GET["service"]."\n");
	}
	$count = 1;
	if (isset($_GET["count"]) && $_GET["count"] != "") {
		if (!is_numeric($_GET["count"])) {
			exit("[ERROR] count is not a number.\n");
		}
		$count = $_GET["count"];
	}
	$index = checkipexist($service, $ip);
	$services = getservices();
	if ($count > 0) {
		if ($index === false) {
			echo "[OK] Add ".$ip." to ".$service." ".$count." times\n";
			$services[$service][]= [$ip, $count];
		} else {
			echo "[OK] Add ".$ip." to ".$service." ".$count." times (origin ".$services[$service][$index][1]." times)\n";
			$services[$service][$index]= [$ip, $count];
		}
	} else {
		if ($index === false) {
			echo "[Warning] ".$ip." is not in ".$service."\n";
		} else {
			echo "[OK] Deleted ".$ip." from ".$service." (origin ".$services[$service][$index][1]." times)\n";
			array_splice($services[$service], $index, 1);
		}
	}
	putservices($services);
}
