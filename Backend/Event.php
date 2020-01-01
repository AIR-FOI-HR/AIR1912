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
   public $dateTime;
   public $ownerId;

   function __construct($id ,$title, $maxNumberOfPeople, $numberOfPeople, $password, $description, $latitude,
   $longitude,$phoneNumber, $isPrivate, $contentID, $customImage, $dateTime, $ownerId)
   {
       $this->id = $id;
       $this->title = $title;
       $this->maxNumberOfPeople = $maxNumberOfPeople;
       $this->numberOfPeople = $numberOfPeople;
       $this->password = $password;
       $this->description = $description;
       $this->latitude = $latitude;
       $this->longitude = $longitude;
       $this->phoneNumber = $phoneNumber;
       $this->isPrivate = $isPrivate;
       $this->contentID = $contentID;
       $this->customImage = $customImage;
       $this->dateTime = $dateTime;
       $this->ownerId = $ownerId;
   }

   function insertNewEvent(){
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();
      
        // Check connection
        if (mysqli_connect_errno())
        {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }

        $query = "INSERT INTO `Event` (`id`, `title`, `maxNumberOfPeople`, `numberOfPeople`, `password`, `description`, `latitude`, `longitude`, `phoneNumber`, 
        `isPrivate`, `contentID`, `customImage`, `dateTime`, `ownerId`) 
        VALUES (NULL, '$this->title', '$this->maxNumberOfPeople', NULL, '$this->password', '$this->description', '$this->latitude', '$this->longitude', NULL, '$this->isPrivate',
         '$this->contentID', NULL, '$this->dateTime', '$this->ownerId')";

        if(!mysqli_query($connectionString,$query)) 
        {
            echo mysqli_error($connectionString);
        die('Error : Query Not Executed. Please Fix the Issue! '); 
        
        } 

        else
        {
        echo "Data Inserted Successully!!!"; 
        }

        // Close connections
        mysqli_close($connectionString);
        

    }
}
?>