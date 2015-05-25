<?php
$free = (disk_free_space('/') * 100) / disk_total_space('/')  ;
if ($free < 20) {
  header('HTTP/1.1 503 Too busy, try again later');
  die('Server too busy. Please try again later.');
}
echo "OK";

