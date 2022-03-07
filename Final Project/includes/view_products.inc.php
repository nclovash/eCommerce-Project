<?php
$toggle = isset($_GET['toggle'])?_GET['toggle']:TRUE;
$order_by = isset($_GET['order_by'])?$_GET['order_by']:'category';
$asc_desc = ($toggle)?'ASC':'DESC';

$select_products = "SELECT category, description, size, keyword, price, stock_quantity, date_added, photo
	FROM mousepads
	INNER JOIN mousepad_categories USING (mousepad_categories_id)
	INNER JOIN mousepad_sizes USING (mousepad_sizes_id)
	INNER JOIN mousepad_colors USING (mousepad_colors_id)
	ORDER BY $order_by $asc_desc";

$exec_select_products = @mysqli_query($link, $select_products);

if(!$exec_select_products){
	rollback('Products info could not be retrieved because '.mysqli_error($link));
}elseif(mysqli_num_rows($exec_select_products) > 0){
	echo "<table class='account_info_table' border=1>
		<tr class='header'>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=category&toggle=".!$toggle."'>Category</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=description&toggle=".!$toggle."'>Description</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=size&toggle=".!$toggle."'>Size</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=keyword&toggle=".!$toggle."'>Keyword</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=price&toggle=".!$toggle."'>Price</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=stock_quantity&toggle=".!$toggle."'>Stock_Quantity</a></th>
			<th><a href='".$_SERVER['PHP_SELF']."?order_by=date_added&toggle=".!$toggle."'>Date_Added</a></th>
			<th>Photo</th>
		</tr>";
	while($one_record = mysqli_fetch_assoc($exec_select_products)){
		echo "<tr>
			<td>{$one_record['category']}</td>
			<td>{$one_record['description']}</td>
			<td>{$one_record['size']}</td>
			<td>{$one_record['keyword']}</td>
			<td>{$one_record['price']}</td>
			<td>{$one_record['stock_quantity']}</td>
			<td>{$one_record['date_added']}</td>
			<td><img src='{$one_record['photo']}'></td>
		</tr>";
	}
	echo "<tr><td colspan='7'>Number of Products:</td><td>".mysqli_num_rows($exec_select_products)."</td></tr></table>";
	mysqli_free_result($exec_select_products);
}else{
	echo "No Products to show";
}
?>