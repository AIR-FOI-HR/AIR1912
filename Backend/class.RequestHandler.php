<?php
require_once('ConnectionData.php');

class RequestHandler{
    public function __construct()
    {
        
    }

    public function getMultipleDataFromDatabase($sqlQuery){
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();
        // Check if there are results
        if ($result = mysqli_query($connectionString, $sqlQuery))
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
        
        return $resultArray;
        }
        
        // Close connections
        mysqli_close($connectionString);  
    }

    public function addOneRowToDatabase($sqlQuery){
        // Create connection Data with connection string
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();
          
           // Check connection
        if (mysqli_connect_errno())
        {
            return false;
            echo "Failed to connect to MySQL: " . mysqli_connect_error();
        } 
        if(!mysqli_query($connectionString,$sqlQuery)) 
        {
            return false;
            die('Error : Query Not Executed. Please Fix the Issue! '); 
        } 
  
        else
        {
           return true;
        }
        // Close connections
        mysqli_close($connectionString);
      }
}
?>