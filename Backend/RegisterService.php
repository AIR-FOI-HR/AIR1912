<?php
 
    function bool UserExists(){
        
    }
    
    
// Create connection
$con=mysqli_connect("localhost","id11519910_projekt","airprojekt2019","id11519910_air1912");
 
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
/*
$json = file_get_contents('php://input');
$data = json_decode($json);

$name = $data['name'];
$surname = $data['surname'];
$email = $data['email'];
$password = $data['password'];
*/

$name = $_POST['name'];
$surname = $_POST['surname'];
$email = $_POST['email'];
$password = $_POST['password'];


$query = "INSERT INTO Users (name, surname, email, password) VALUES ('$name', '$surname', '$email', '$password')";

if(!mysqli_query($con,$query)) 
{
   die('Error : Query Not Executed. Please Fix the Issue! '); 
} 

else
{
   echo "Data Inserted Successully!!!"; 
}

// Close connections
mysqli_close($con);
?>
