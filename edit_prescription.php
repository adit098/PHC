<?php
//Start the session to see if the user is authenticated user. 
session_start(); 
//Check if the user is authenticated first. Or else redirect to login page 
if(isset($_SESSION['IS_AUTHENTICATED']) && $_SESSION['IS_AUTHENTICATED'] == 1){ 
require('navigation.php'); 
// Code to be executed when 'Insert' is clicked. 
if ($_POST['submit'] == 'Insert'){
//validation flag to check that all validations are done 
$validationFlag = true; 
//Check all the required fields are filled 
if(!($_POST['drug_name']))
{ 
echo 'All the fields marked as * are compulsary.<br>'; 
$validationFlag = false; 
} 

else{ 
// $p_no = $_POST['p_no']; 
$drug_name = $_POST['drug_name'];  
$quantity = $_POST['quantity']; 
}


//If all validations are correct, connect to MySQLi and execute the query 
if($validationFlag){ 
//Connect to mysqli server 
$link = mysqli_connect('localhost', 'root', ''); 
//Check link to the mysqli server 
if(!$link){ 
die('Failed to connect to server: ' . mysqli_error($link)); 
} 
//Select database 
$db = mysqli_select_db($link,'phc'); 
if(!$db){ 
die("Unable to select database"); 
} 
//Create Insert query
$qry = "select max(patient_no) as max_sno from patient_entry"; 
$max_sno = mysqli_query($link,$qry);
$get_sno = mysqli_fetch_assoc($max_sno);
$p_no = $get_sno['max_sno'];
$query = "INSERT INTO prescription (p_no, drug_name, quantity) VALUES ('$p_no', '$drug_name', '$quantity')"; 
//Execute query 
$results = mysqli_query($link,$query); 
 
//Check if query executes successfully 
if($results == FALSE) 
echo mysqli_error($link) . '<br>'; 
else
	header('location: register_prescription.php ');

} 
} 
if ($_POST['confirm'] == 'Confirm'){
	header('location: main_page.php');
}
 


// Code to be executed when 'Update' is clicked. 
// Code to be executed when 'Delete' is clicked. 

} 


else{ 
header('location:login_form.php'); 
exit(); 
} 
?>
