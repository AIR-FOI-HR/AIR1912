<?php

require_once("ConnectionData.php");
require_once('class.RequestHandler.php');



class DBContent{
   public $id;
   public $sourceEntityId;
   public $type;
   public $title;
   public $overview;
   public $poster_path;
   public $release_date;
   public $runtime;
   public $posterURL;

   function __construct($id ,$sourceEntityId, $type, $title, $overview, $poster_path, $release_date,
   $runtime,$posterURL)
   {
       $this->id = $id;
       $this->sourceEntityId = $sourceEntityId;
       $this->type = $type;
       $this->title = $title;
       $this->overview = $overview;
       $this->poster_path = $poster_path;
       $this->release_date = $release_date;
       $this->runtime = $runtime;
       $this->posterURL = $posterURL;
   }
   
   function insertNewContent(){
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();
        $requestHandler = new RequestHandler();
      
       
        if (mysqli_connect_errno())
        {
        echo "Failed to connect to MySQL: " . mysqli_connect_error();
        }

        $query = "INSERT INTO `Contents` (`id`, `sourceEntityId`, `type`, `title`, `overview`, `poster_path`, `release_date`, `runtime`, `posterURL`) 
        VALUES (NULL, '$this->sourceEntityId', '$this->type', '$this->title', '$this->overview', '$this->poster_path', 
        '$this->release_date', '$this->runtime', '$this->posterURL')";
        $insertData = $requestHandler->addOneRowToDatabase($query);
        if($insertData ===FALSE){
            return FALSE;
        }

        $sqlQuery = "SELECT Contents.* FROM Contents WHERE sourceEntityId = '$this->sourceEntityId'  AND type = '$this->type'";
        $data = $requestHandler->getMultipleDataFromDatabase($sqlQuery);
        $dataEncoded = json_encode($data, JSON_NUMERIC_CHECK);
       
        echo $dataEncoded;
        
        
        
        mysqli_close($connectionString);
        return TRUE;

    }
}
?>