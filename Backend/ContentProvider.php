<?php

error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);

require_once("ConnectionData.php");


$connectionData = new ConnectionData();
$connectionString = $connectionData->getConnectionString();

$id = $_GET['searchByID'];

if(!empty($id)){
    $sql  = "SELECT `sourceEntityId`,`type`,`title`,`overview`,`poster_path`,`release_date`,`runtime`,`posterURL`  FROM `Contents`  WHERE id='$id' ";
        
        
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
}

?>