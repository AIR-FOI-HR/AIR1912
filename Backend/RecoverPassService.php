<?php
 
 class ReturnCodes {
    public $code;
    public $message;
}
 
 

$con=mysqli_connect("localhost","id11519910_projekt","airprojekt2019","id11519910_air1912");
 

if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
 
 $userEmail= $_POST['email'];
 //$userEmail = 'lleljak@foi.hr';

$sql = "SELECT * FROM Users WHERE email = '$userEmail'";
 
$returnCode= new ReturnCodes();
if ($result = mysqli_query($con, $sql))
{

    $objQuery = mysql_query($sql);
    $objResult = mysql_fetch_array($objQuery);
    if(!$objResult)
    {
            echo "Not Found Username or Email!";
    }
    else
    {
            
            $returnCode->code ='400';
            $returnCode->message='OK';

            $strTo = $objResult["email"];
            $strSubject = "Your Account information username and password.";
            $strHeader = "Content-type: text/html; charset=windows-874\n"; // or UTF-8 //
            $strHeader .= "From: webmaster@thaicreate.com\nReply-To: webmaster@thaicreate.com";
            $strMessage = "";
            $strMessage .= "Welcome : ".$objResult["name"]."<br>";
            $strMessage .= "Username : ".$objResult["email"]."<br>";
            $strMessage .= "Password : ".$objResult["password"]."<br>";
            $strMessage .= "=================================<br>";
            $strMessage .= "ThaiCreate.Com<br>";
            $flgSend = mail($strTo,$strSubject,$strMessage,$strHeader);

    }
     
 
 
 echo json_encode($returnCode);
}
 
// Close connections
mysqli_close($con);
?>
