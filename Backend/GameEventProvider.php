<?php

error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);

require_once("ConnectionData.php");


//Ako proslijedimo searchByID, onda pretrazujemo Evente na koje je korisnik sa ID prijavljen
//dopuniti funkcije
//ako nema ni jednog proslijeđenog parametra, vraćamo sve Public Evente

$id = $_GET['searchByID'];
$sql= "";


if(!empty($id)){
    $sql  = "SELECT Event.* FROM `Event` JOIN MyEvent ON MyEvent.idEvent = Event.id JOIN Users ON MyEvent.idUser=Users.idUsers WHERE Users.idUsers = '$id' AND Event.isPrivate = 0";

}
else
{
    $sql  = 'SELECT * FROM `Event` WHERE isPrivate=0';
       
}

doQuery($sql);

function doQuery($sql){
    $connectionData = new ConnectionData();
    $connectionString = $connectionData->getConnectionString();

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