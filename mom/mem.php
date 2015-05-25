<?php
function getSystemMemInfo() 
{       
  $data = explode("\n", file_get_contents("/proc/meminfo"));
  $meminfo = array();
  foreach ($data as $line) {
    $ex = explode(":", $line);
    if(count($ex) != 2) continue;
    list($key,$val) = $ex;
    preg_match('/[0-9]+/',$val,$r);
    $meminfo[$key] = $r[0]*1024;
  }
  return $meminfo;
}

$mem = getSystemMemInfo();
$free = (( $mem['MemFree'] + $mem['Cached']  )* 100) / $mem['MemTotal']  ;
if ($free < 20) {
  header('HTTP/1.1 503 Too busy, try again later');
  die('Server too busy. Please try again later.');
}
echo "OK";

