<?php
session_start();
$title = 'Account Info';
require('./includes/mysql.inc.php');
$errors_array = array();
require('./includes/functions.inc.php');
if(isset($_SESSION['mousepad_customers_id']) && isset($_SESSION['full_name'])){
	$mousepad_customers_id = $_SESSION['mousepad_customers_id'];
	include('./includes/header.inc.php');

	require('./includes/account_info.inc.php');

	include('./includes/footer.inc.php');
}else{
	redirect('You are not an authentic user', 'login.php', 1);
}
?>