<?php
$title = 'Registration';
require('./includes/mysql.inc.php');
$errors_array = array();
require('./includes/functions.inc.php');

if(!empty($_POST['form_submitted'])){
	require('./includes/registration_handle_homework.inc.php');
}
include('./includes/header.inc.php');
require('./includes/registration_homework.inc.php');

include('./includes/footer.inc.php');
?>