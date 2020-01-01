<?php
require_once('ConnectionData.php');

class RequestHandler{
    public $sqlQuery;

    public function __construct($sqlQuery)
    {
        $this->sqlQuery = $sqlQuery;
    }

    public function getMultipleDataFromDatabase(){
        $connectionString = new ConnectionData();
        
        // Check if there are results
        if ($result = mysqli_query($connectionString, $this->sqlQuery))
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