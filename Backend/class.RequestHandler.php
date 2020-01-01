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

    public function tryToInsertData($sqlQuery){
        $connectionData = new ConnectionData();
        $connectionString = $connectionData->getConnectionString();

        $result = mysqli_query($connectionString, $sqlQuery);

        if($result === TRUE){
            return TRUE;
        }
        else {
            return FALSE;
        }
    }

}
?>