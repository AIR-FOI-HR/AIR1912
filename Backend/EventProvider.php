<?php

//error_reporting(E_ALL);
//ini_set('display_errors', TRUE);
//ini_set('display_startup_errors', TRUE);

require_once("class.RequestHandler.php");



//Ako proslijedimo searchByID, onda pretrazujemo Evente na koje je korisnik sa ID prijavljen
//dopuniti funkcije
//ako nema ni jednog proslijeđenog parametra, vraćamo sve Public Evente

$postType = $_GET['postType'];
$eventType = $_GET['eventType'];
$firstParam = $_GET['firstParam'];
$sql= "";

//Event type [0: Public, 1: Private, 2: All]
//Post type (searchByUserId, allEvents, ...) 

switch ($postType) {
    case "searchByUserId":
        if($eventType=2){
            $sql  = "SELECT Event.* FROM `Event` JOIN MyEvent ON MyEvent.idEvent = Event.id JOIN Users ON MyEvent.idUser=Users.idUsers WHERE Users.idUsers = '$firstParam'";
        }else{
        $sql  = "SELECT Event.* FROM `Event` JOIN MyEvent ON MyEvent.idEvent = Event.id JOIN Users ON MyEvent.idUser=Users.idUsers WHERE Users.idUsers = '$firstParam' AND Event.isPrivate = '$eventType'";}
        break;
    case "allEvents":
        $sql  = "SELECT Event.* FROM `Event`";
        break;
    /*case label3:
        code to be executed if n=label3;
        break;*/
    default:
        $sql  = "SELECT Event.* FROM `Event`";
        
        break;
}


$requestHandler = new RequestHandler();
$data = $requestHandler->getMultipleDataFromDatabase($sql);
echo json_encode($data, JSON_NUMERIC_CHECK)

?>