<?php
$toggle = isset($_GET['toggle'])?$_GET['toggle']:TRUE;
$order_by = isset($_GET['order_by'])?$_GET['order_by']:'category';
$asc_desc = ($toggle)?'ASC':'DESC';

$select_previous_orders = "SELECT mousepad_orders_mousepads.mousepad_orders_id, CONCAT_WS(' ',mousepad_shipping_addresses.address_1, mousepad_shipping_addresses.address_2, mousepad_shipping_addresses.city, state, mousepad_shipping_addresses.zip) as 'Shipping Address', CONCAT_WS(' ',mousepad_billing_addresses.address_1, mousepad_billing_addresses.address_2, mousepad_billing_addresses.city, state, mousepad_billing_addresses.zip) as 'Billing Address', GROUP_CONCAT(category SEPARATOR '<br><hr>') as category, GROUP_CONCAT(size SEPARATOR '<br><hr>') as size, GROUP_CONCAT(keyword SEPARATOR '<br><hr>') as keyword, GROUP_CONCAT(mousepad_orders_mousepads.quantity SEPARATOR '<br><hr>') as quantity, GROUP_CONCAT(mousepad_orders_mousepads.price SEPARATOR '<br><hr>') as price, credit_no, credit_type, order_total, shipping_fee, order_date, shipping_date
	FROM mousepad_customers
	INNER JOIN mousepad_states USING (mousepad_states_id)
	INNER JOIN mousepad_orders USING (mousepad_customers_id)
	INNER JOIN mousepad_shipping_addresses USING (mousepad_shipping_addresses_id)
	INNER JOIN mousepad_billing_addresses USING (mousepad_billing_addresses_id)
	INNER JOIN mousepad_orders_mousepads USING (mousepad_orders_id)
	INNER JOIN mousepads USING (mousepads_id)
	INNER JOIN mousepad_categories USING (mousepad_categories_id)
	INNER JOIN mousepad_sizes USING (mousepad_sizes_id)
	INNER JOIN mousepad_colors USING (mousepad_colors_id)
	WHERE mousepad_customers_id = $mousepad_customers_id AND
	(shipping_date > NOW() || shipping_date = '' || shipping_date is NULL || shipping_date = 0)
	GROUP BY mousepad_orders_mousepads.mousepad_orders_id
	ORDER BY $order_by $asc_desc";

$exec_select_previous_orders = @mysqli_query($link, $select_previous_orders);
if(!$exec_select_previous_orders){
	rollback('Previous orders could not be retrieved becase '.mysqli_error($link));
}elseif(mysqli_num_rows($exec_select_previous_orders) > 0){
	echo "<table class='product_info_table'>
		<tr class='header'>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=mousepad_shipping_addresses.address_1&toggle=".!$toggle."'>Shipping Address</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=mousepad_billing_addresses.address_1&toggle=".!$toggle."'>Billing Address</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=category&toggle=".!$toggle."'>Category</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=size&toggle=".!$toggle."'>Size</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=keyword&toggle=".!$toggle."'>Color</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=mousepad_orders_mousepads.quantity&toggle=".!$toggle."'>Quantity</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=mousepad_orders_mousepads.price&toggle=".!$toggle."'>Price</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=credit_no&toggle=".!$toggle."'>Credit No</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=credit_type&toggle=".!$toggle."'>Credit Type</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=order_total&toggle=".!$toggle."'>Order Total</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=shipping_fee&toggle=".!$toggle."'>Shipping Fee</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=order_date&toggle=".!$toggle."'>Order Date</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=shipping_date&toggle=".!$toggle."'>Shipping Date</a></th>
			<th>Cancel</th>
		</tr>";
	while($one_record = mysqli_fetch_assoc($exec_select_previous_orders)){
		echo "<tr>
			<td>{$one_record['Shipping Address']}</td>
			<td>{$one_record['Billing Address']}</td>
			<td>{$one_record['category']}</td>
			<td>{$one_record['size']}</td>
			<td>{$one_record['keyword']}</td>
			<td>{$one_record['quantity']}</td>
			<td>\${$one_record['price']}</td>
			<td>{$one_record['credit_no']}</td>
			<td>{$one_record['credit_type']}</td>
			<td>\${$one_record['order_total']}</td>
			<td>\${$one_record['shipping_fee']}</td>
			<td>{$one_record['order_date']}</td>
			<td>{$one_record['shipping_date']}</td>
			<td><a href='".$_SERVER['PHP_SELF']."?mousepad_orders_id=".$one_record['mousepad_orders_id']."'>Cancel</a></td>
		</tr>";
	}
	echo "<tr><td colspan='13'>Number of orders that have not shipped:</td><td>".mysqli_num_rows($exec_select_previous_orders)."</td></tr></table>";
	mysqli_free_result($exec_select_previous_orders);
}else{
	echo "No Current Order has not shipped";
}
?>