<?php

require_once("ConnectionData.php");
require_once("class.RequestHandler.php");

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
        
        }else
        {
            $newRecordId = mysql_insert_id();
            $sql  = "SELECT Event.* FROM `Event` WHERE id = '$newRecordId'";
            $requestHandler = new RequestHandler();
            $data = $requestHandler->getMultipleDataFromDatabase($sql);
            echo json_encode($data, JSON_NUMERIC_CHECK);
        }
        mysqli_close($connectionString);  
    }

    function updateEvent(){
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();
      
        
        if (mysqli_connect_errno())
        {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }

        $query = "UPDATE `Event` SET `title` = '$this->title', `maxNumberOfPeople` = '$this->maxNumberOfPeople', `password` = '$this->password', `description` = '$this->description', `latitude` = '$this->latitude', `longitude` = '$this->longitude', `isPrivate` = '$this->isPrivate', `contentID` = '$this->contentID', `dateTime` = '$this->dateTime' WHERE `Event`.`id` = '$this->id'";

        if(!mysqli_query($connectionString,$query)) 
        {
            echo mysqli_error($connectionString);
            die('Error : Query Not Executed. Please Fix the Issue! '); 
        
        }else
        {
            $updatedRecordId = $this->id;
            $sql  = "SELECT Event.* FROM `Event` WHERE id = '$updatedRecordId'";
            $requestHandler = new RequestHandler();
            $data = $requestHandler->getMultipleDataFromDatabase($sql);
            echo json_encode($data, JSON_NUMERIC_CHECK);
        }
        mysqli_close($connectionString);  
        
    }

}
?>