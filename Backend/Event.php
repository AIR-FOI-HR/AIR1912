<?php

require_once("ConnectionData.php");

class Event{
   public $id;
   public $title;
   public $maxNumberOfPeople;
   public $numberOfPeople;
   public $password;
   public $description;
   public $latitude;
   public $longitude;
   public $phoneNumber;
   public $isPrivate;
   public $contentID;
   public $customImage;

   

   static function returnAllGameEvents(){
        $sql = "SELECT * FROM Event WHERE type = 'movie''";
        
        // Check if there are results
        if ($result = mysqli_query($connectionString, $sql))
        {
       
        $resultArray = array();
        $tempArray = array();
        
       
        while($row = $result->fetch_object())
        {
        // Add each row into our results array
            $tempArray = $row;
            if ($tempArray){
                
                array_push($resultArray, $tempArray );
            }
            // array_push($resultArray, $tempArray);
            
        }
        
        echo $resultArray;
        }
        
        // Close connections
        mysqli_close($connectionString);  

    }
}
?>