<?php



include 'Event.php';
include 'jsonResponse.php';



//Types of get calls
$requestType = $_GET['requestType'];

$eventId = $_GET['id'];
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
$deletionId = $_GET['deletionId'];
$userId = $_GET['userId'];
$eventJoinId = $_GET['eventJoinId'];




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
        Event::deleteEvent($deletionId);
        break;
    case "joinUserToEvent":
        $sqlQuery = "INSERT INTO MyEvent (`idUser`, `idEvent`) VALUES ('$userId', '$eventJoinId')";
        $isInserted = RequestHandler::addOneRowToDatabase($sqlQuery);
        if($isInserted == false){
            $response = JsonResponseBuilder::error_response('Not inserted', 'Try again later', '400');
            echo $response;
        }else{
            $sqlQuery = "UPDATE Event SET numberOfPeople = numberOfPeople + 1";
            RequestHandler::addOneRowToDatabase($sqlQuery);
            echo json_encode("Inserted");
        }
       break;
    case "deleteUserFromEvent":
        $sqlQuery = "DELETE FROM `MyEvent` WHERE `MyEvent`.`idUser` = '$userId' AND `MyEvent`.`idEvent` = '$eventJoinId'";
        $isDeleted = RequestHandler::addOneRowToDatabase($sqlQuery);
        if($isDeleted == false){
            $response = JsonResponseBuilder::error_response('Not deleted', 'Try again later', '400');
            echo $response;
        }else{
            $sqlQuery = "UPDATE Event SET numberOfPeople = numberOfPeople - 1";
            RequestHandler::addOneRowToDatabase($sqlQuery);
            echo json_encode("Deleted");
        }
    default:
        break;
}








?>