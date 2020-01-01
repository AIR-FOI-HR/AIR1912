<?php



include 'Event.php';
include 'jsonResponse.php';


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

$newEvent = new Event(0, $title, $maxNumberOfPeople, 0, $password, $description, $latitude, $longitude, $phoneNumber, $isPrivate, $contentID, $customImage, $dateTime, $ownerId);

$newEvent->insertNewEvent();


//napraviti Switch logiku, vratiti van kod funkcije insertNewEvent event koji se kreirao






?>