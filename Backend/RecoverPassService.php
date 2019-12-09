<?php
 
require_once("ConnectionData.php");
include 'jsonResponse.php';


$connectionData = new ConnectionData();
$connectionString = $connectionData->getConnectionString();

if (mysqli_connect_errno())
{
   echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 $userEmailNickname= $_POST['email'];


$sql = "SELECT * FROM Users WHERE email = '$userEmailNickname' OR nickname='$userEmailNickname'";
 

if ($result = mysqli_query($connectionString, $sql))
{

    
    $objResult = $result->fetch_array();
    if(!$objResult)
    {
          $response = JsonResponseBuilder::error_response('Credentials not right', 'Try again', '400');
    }
    else
    {
            
            

            $strTo = $objResult["email"];
            
            $strSubject = "Your Account information username and password.";
            $strHeader = "Content-type: text/html; charset=windows-874\n"; // or UTF-8 //
            $strHeader .= "From: airprojekt.com\nReply-To: airprojekt@gmail.com";
            $strMessage = "";
            $strMessage .= "Welcome : ".$objResult["name"]."<br>";
            $strMessage .= "Username : ".$objResult["email"]."<br>";
            $strMessage .= "Password : ".$objResult["password"]."<br>";
            $strMessage .= "=================================<br>";
            if( mail($strTo,$strSubject,$strMessage,$strHeader)){
                $response = JsonResponseBuilder::success_response($objResult);
            }

    }
     
 
 
 echo $response;
}
 

mysqli_close($connectionString);
?>
