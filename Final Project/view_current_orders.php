<?php
session_start();
$title = 'Pending Orders';
require('./includes/mysql.inc.php');
$errors_array = array();
require('./includes/functions.inc.php');
if(isset($_SESSION['mousepad_customers_id']) && isset($_SESSION['full_name'])){
	$mousepad_customers_id = $_SESSION['mousepad_customers_id'];
	if(isset($_GET['mousepad_orders_id'])){
		$mousepad_orders_id = $_GET['mousepad_orders_id'];
		require('./includes/cancel_orders.inc.php');
	}else{
		include('./includes/header.inc.php');
		require('./includes/view_current_orders.inc.php');
	}
	include('./includes/footer.inc.php');
}else{
	redirect('You are not an authentic user', 'login.php', 1);
}
?>