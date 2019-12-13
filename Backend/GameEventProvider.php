<?php

error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);

require_once("ConnectionData.php");


$connectionData = new ConnectionData();
$connectionString = $connectionData->getConnectionString();

$sql  = 'SELECT * FROM `Event` WHERE isPrivate=0';
        
       
        if ($result = mysqli_query($connectionString, $sql))
        {
       
        $resultArray = array();
        $tempArray = array();
        
       
        while($row = $result->fetch_object())
        {
        
            $tempArray = $row;
            if ($tempArray){
               
                array_push($resultArray, $tempArray );
                

            }
          
        }
        
        echo json_encode($resultArray, JSON_NUMERIC_CHECK);
        }
        
        
        mysqli_close($connectionString);  

?>