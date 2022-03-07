<?php
mysqli_query($link, "SET AUTOCOMMIT = 0");
$select_mousepads = "SELECT mousepads_id, quantity from mousepad_orders_mousepads WHERE mousepad_orders_id = $mousepad_orders_id";
$exec_select_mousepads = @mysqli_query($link, $select_mousepads);
if(!$exec_select_mousepads){
	rollback('Ordered mousepads could not be retrieved becase '.mysqli_error($link));
}else{
	while($one_record = mysqli_fetch_assoc($exec_select_mousepads)){
		$quantity = $one_record['quantity'];
		$mousepads_id = $one_record['mousepads_id'];
		$update_mousepads = "UPDATE mousepads set stock_quantity = (stock_quantity+$quantity) WHERE mousepads_id = $mousepads_id";
		$exec_update_mousepads = @mysqli_query($link, $update_mousepads);
		if(!$exec_select_mousepads){
			rollback('Update was not successful becase '.mysqli_error($link));
		}
	}
	$delete_order = "DELETE mousepad_shipping_addresses.*, mousepad_billing_addresses.*, mousepad_transactions.* FROM mousepad_orders 
	INNER JOIN mousepad_billing_addresses USING (mousepad_billing_addresses_id)
	INNER JOIN mousepad_shipping_addresses USING (mousepad_shipping_addresses_id)
	INNER JOIN mousepad_transactions USING (mousepad_transactions_id)
	WHERE mousepad_orders_id = $mousepad_orders_id";
	$exec_delete_order = @mysqli_query($link, $delete_order);
	if(!$exec_delete_order){
		rollback('Delete was not successful becase '.mysqli_error($link));
	}else{
		mysqli_query($link, "COMMIT");
		redirect('successfully deleted...', 'view_current_orders.php', 1);
	}	
}
?>