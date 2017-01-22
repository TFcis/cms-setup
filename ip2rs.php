<?php
if (!isset($_GET["ip"])) {
	exit("[ERROR] No IP\n");
}
$ipfile=file_GET_contents("ip.txt");
preg_match_all("/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/", $ipfile, $m);
$ip=$m[0];
$worker=array_keys($ip, $_GET["ip"])[0];
if (is_null($worker)) {
	exit("-1");
}
echo $worker+1;
