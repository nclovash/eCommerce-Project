<?php
	DEFINE('HOST','localhost');
	DEFINE('USER', 'nclovash');
	DEFINE('PASS', 'Alienware73!');
	DEFINE('DB', 'nclovash_ecommerce');

$link = @mysqli_connect(HOST, USER, PASS, DB) or die('The following error occurred: '.mysqli_connect_error());
mysqli_set_charset($link, 'utf8');
?>