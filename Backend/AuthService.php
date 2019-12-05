<?php
 
require_once("ConnectionData.php");
include 'jsonResponse.php';
    
$connectionData = new ConnectionData();
$connectionString = $connectionData->getConnectionString();

if (mysqli_connect_errno())
{
   echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
$name= $_GET['name'];
$password= $_GET['password'];

$sql = "SELECT * FROM Users WHERE name = '$name' AND password= '$password'";
 

if ($result = mysqli_query($connectionString, $sql))
{
 $resultArray = array();
 $tempArray = array();
 
 while($row = $result->fetch_object())
 {
    $tempArray = $row;
    if ($tempArray){
        
        array_push($resultArray, $tempArray );
    }
 }
 
 if(empty($resultArray)){
     $response = JsonResponseBuilder::error_response('Credentials not right', 'Try again', '400');
 }

 else{
     $response = JsonResponseBuilder::success_response($resultArray);
 }

 echo $response;
}
 
mysqli_close($connectionString);
?>
