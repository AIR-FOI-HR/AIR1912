<?php



include 'DBContent.php';
include 'jsonResponse.php';


$requestType = $_GET['requestType'];
$sourceEntityId = $_GET['sourceEntityId'];
$type= $_GET['type'];
$title= $_GET['title'];
$overview = $_GET['overview'];
$poster_path = $_GET['poster_path'];
$release_date= $_GET['release_date'];
$runtime= $_GET['runtime'];
$posterURL= $_GET['posterURL'];

switch ($requestType) {
    case "insertNewContent":
        $newContent = new DBContent(0, $sourceEntityId, $type, $title, $overview, $poster_path, $release_date, $runtime, $posterURL);
        if ($newContent->insertNewContent()=== TRUE){
            
        }
        else {
            $response = JsonResponseBuilder::error_response('Credentials not right', 'Try again', '400');
            echo $response;
        }

    default:
        break;
}









?>