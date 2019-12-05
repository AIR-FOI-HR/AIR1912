<?php
 
require_once("ConnectionData.php");
include 'jsonResponse.php';
    
$connectionData = new ConnectionData();
$connectionString = $connectionData->getConnectionString();

// Check connection
if (mysqli_connect_errno())
{
   echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
 $name= $_GET['name'];
 $password= $_GET['password'];


// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM Users WHERE name = '$name' AND password= '$password'";
 
// Check if there are results
if ($result = mysqli_query($connectionString, $sql))
{
 // If so, then create a results array and a temporary one
 // to hold the data
 $resultArray = array();
 $tempArray = array();
 
 // Loop through each row in the result set
 while($row = $result->fetch_object())
 {
 // Add each row into our results array
    $tempArray = $row;
    if ($tempArray){
        
        array_push($resultArray, $tempArray );
    }
    // array_push($resultArray, $tempArray);
     
 }
 
 if(empty($resultArray)){
     $response = JsonResponseBuilder::error_response('Credentials not right', 'Try again', '400');
 }

 else{
     $response = JsonResponseBuilder::success_response($resultArray);
 }

 echo $response;
}
 
// Close connections
mysqli_close($connectionString);
?>
