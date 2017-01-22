<?php
$ipfile=file_GET_contents("ip.txt");
$cfgfile=file_GET_contents("cms.example.conf");
preg_match_all("/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/", $ipfile, $m);
$iplist=$m[0];
$ResourceServiceorigin='["192.168.7.219", 28000]';
$ResourceServiceadd=",\n\t\t\t\t\t\t\t\t".'["$1", 28000]';
$ResourceServicestr="";
$Workerorigin='["192.168.7.219", 26000], ["192.168.7.219", 26001]';
$Workeradd=",\n\t\t\t\t".'["$1", 26000],["$1", 26001],["$1", 26002],["$1",26003]';
$Workerstr="";
foreach ($iplist as $ip) {
	$ResourceServicestr.=str_replace("$1", $ip, $ResourceServiceadd);
	$Workerstr.=str_replace("$1", $ip, $Workeradd);
}
$cfgfile=str_replace($ResourceServiceorigin, $ResourceServiceorigin.$ResourceServicestr, $cfgfile);
$cfgfile=str_replace($Workerorigin, $Workerorigin.$Workerstr, $cfgfile);
file_put_contents("cms.conf", $cfgfile);
