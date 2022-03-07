<?php

//mysqli_real_escape_string($link, $data);

if(!empty($_POST['first_name'])&&is_string($_POST['first_name'])){
	$first_name = htmlspecialchars(add_slashes($_POST['first_name']));
}else{
	$errors_array['first_name'] = "Please enter a valid first name!";
}

if(!empty($_POST['last_name'])&&is_string($_POST['last_name'])){
	$last_name = htmlspecialchars(add_slashes($_POST['last_name']));
}else{
	$errors_array['last_name'] = "Please enter a valid last name!";
}

if(!empty($_POST['email'])&&filter_var($_POST['email'], FILTER_VALIDATE_EMAIL)){
	$email = htmlspecialchars(add_slashes($_POST['email']));
}else{
	$errors_array['email'] = "Please enter a valid email!";
}

if(!empty($_POST['phone'])){
	$phone = htmlspecialchars(add_slashes($_POST['phone']));
}else{
	$errors_array['phone'] = "Please enter a valid phone!";
}

if(!empty($_POST['password'])){
	$password = htmlspecialchars($_POST['password']);
}else{
	$errors_array['password'] = "Please enter a valid password!";
}

if(!empty($_POST['address_1'])){
	$address_1 = htmlspecialchars(add_slashes($_POST['address_1']));
}else{
	$errors_array['address_1'] = "Please enter a valid home address!";
}

if(!empty($_POST['address_2'])){
	$address_2 = htmlspecialchars(add_slashes($_POST['address_2']));
}else{
	$address_2 = null;
}

if(!empty($_POST['city'])){
	$city = htmlspecialchars(add_slashes($_POST['city']));
}else{
	$errors_array['city'] = "Please enter a valid City!";
}

if(isset($_POST['mousepad_states_id'])){
	$mousepad_states_id = $_POST['mousepad_states_id'];
}else{
	$errors_array['mousepad_states_id'] = "Please pick a state!";
}

if(!empty($_POST['zip'])){
	$zip = htmlspecialchars(add_slashes($_POST['zip']));
}else{
	$errors_array['zip'] = "Please enter a valid zip!";
}

if(!empty($_POST['date_created'])){
	$date_created = htmlspecialchars(add_slashes($_POST['date_created']));
}else{
	$errors_array['date_created'] = "Please enter a valid date!";
}

if(count($errors_array)==0){
	mysqli_query($link, 'AUTOCOMMIT = 0');
	$insert_into_mousepad_customers = "INSERT INTO mousepad_customers (first_name, last_name, email, phone, password, address_1, address_2, city, mousepad_states_id, zip, date_created) VALUES
	('$first_name', '$last_name', '$email', '$phone', '".password_hash($password, PASSWORD_BCRYPT)."', '$address_1', '$address_2', '$city', $mousepad_states_id, '$zip', '$date_created')";
	$exec_insert_into_mousepad_customers = @mysqli_query($link, $insert_into_mousepad_customers);
	if(!$exec_insert_into_mousepad_customers){
		rollback("The following error occurred when inserting into mousepad_customers: ".mysqli_error($link));
	}else{
		mysqli_query($link, 'COMMIT');
		redirect('You are successfully registered.. You are now being redirected to login page..', 'login.php', 2);
	}
}




?>