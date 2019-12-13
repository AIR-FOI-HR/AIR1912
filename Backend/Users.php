<?php

require_once("ConnectionData.php");

class Users{
   public $idUsers;
   public $nickname;
   public $name;
   public $surname;
   public $email;
   public $password;
   public $avatar;

   function __construct($idUsers ,$nickname, $name, $surname, $email, $password, $avatar)
   {
       $this->idUsers = $idUsers;
       $this->nickname = $nickname;
       $this->name = $name;
       $this->surname = $surname;
       $this->email = $email;
       $this->password = $password;
       $this->avatar = $avatar;
   }

   function CheckIfUserExists(){
       // Create connection Data with connection string
      $connectionData = new ConnectionData();
      $connectionString = $connectionData->getConnectionString();
      
      // Check connection
      if (mysqli_connect_errno())
      {
         echo "Failed to connect to MySQL: " . mysqli_connect_error();
      }
      
      // This SQL statement selects ALL from the table 'Locations'
      $sql = "SELECT * FROM Users WHERE email = '$this->email' OR nickname = '$this->nickname'";
      
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
               array_push($resultArray, $tempArray);
            }
        }
         
        if(!empty($resultArray)){
            return true;
        }
        
        else return false;

      }
   }


   public function addNewUser(){
      // Create connection Data with connection string
      $connectionData = new ConnectionData();
      $connectionString = $connectionData->getConnectionString();
        
         // Check connection
      if (mysqli_connect_errno())
      {
         echo "Failed to connect to MySQL: " . mysqli_connect_error();
      }

      $query = "INSERT INTO Users (nickname, name, surname, email, password, avatar) VALUES ('$this->nickname', '$this->name', '$this->surname', '$this->email', '$this->password', '$this->avatar')";

      if(!mysqli_query($connectionString,$query)) 
      {
         die('Error : Query Not Executed. Please Fix the Issue! '); 
      } 

      else
      {
         //echo "Data Inserted Successully!!!"; 
      }

      // Close connections
      mysqli_close($connectionString);
         
    }
    
    
    function getUserByEmail(){
        // Create connection Data with connection string
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();
          
        // Check connection
        if (mysqli_connect_errno())
        {
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }
          
        // This SQL statement selects ALL from the table 'Locations'
        $sql = "SELECT * FROM Users WHERE email = '$this->email' ";
          
        // Check if there are results
        if ($result = mysqli_query($connectionString, $sql))
        {
            // If so, then create a results array and a temporary one
            // to hold the data
            $resultArray = mysqli_fetch_assoc($result);
            return $resultArray;
        } else {
             return null;
        }
    }

}
?>