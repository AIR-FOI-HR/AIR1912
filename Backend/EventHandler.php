<?php



include 'Event.php';
include 'jsonResponse.php';


//Types of get calls
$requestType = $_GET['requestType'];

$eventId = $_GET['eventId'];
$title = $_GET['title'];
$maxNumberOfPeople = $_GET['maxNumberOfPeople'];
$numberOfPeople= $_GET['numberOfPeople'];
$password= $_GET['password'];
$description = $_GET['description'];
$latitude = $_GET['latitude'];
$longitude= $_GET['longitude'];
$phoneNumber= $_GET['phoneNumber'];
$isPrivate= $_GET['isPrivate'];
$contentID= $_GET['contentID'];
$customImage= $_GET['customImage'];
$dateTime= $_GET['dateTime'];
$ownerId= $_GET['ownerId'];




switch ($requestType) {
    case "insert":
        $newEvent = new Event(0, $title, $maxNumberOfPeople, 0, $password, $description, $latitude, $longitude, $phoneNumber, $isPrivate, $contentID, $customImage, $dateTime, $ownerId);
        $newEvent->insertNewEvent();
        break;

    case "update":
        $modificationEvent = new Event($eventId, $title, $maxNumberOfPeople, 0, $password, $description, $latitude, $longitude, $phoneNumber, $isPrivate, $contentID, $customImage, $dateTime, $ownerId);
        $modificationEvent->updateEvent();
        break;
    case "delete":
        break;
        
    default:
        break;
}








?>