<?php


require_once('class.RequestHandler.php');
require_once('jsonResponse.php');



$sqlQuery;

if(isset($_GET['requestType'])){
    $requestType = $_GET['requestType'];
    $parameter1 = $_GET['parameter1'];
    $parameter2 = $_GET['parameter2'];
    
}
else{
    echo JsonResponseBuilder::error_response('Sorry but...','There was error with your request!', 400);
}

switch ($requestType){
    case "getFavouritesForUserId":
        // parameter 1: userId, parameter 2: contentType
        $sqlQuery = "SELECT Contents.* FROM Contents LEFT OUTER JOIN FavouriteContent On Contents.id = FavouriteContent.idContent WHERE FavouriteContent.idUser = {$parameter1} AND Contents.type = '$parameter2'";
        getFavourites($sqlQuery);
        break;
    
    case "getContentById":
        $sqlQuery  = "SELECT `sourceEntityId`,`type`,`title`,`overview`,`poster_path`,`release_date`,`runtime`,`posterURL`  FROM `Contents`  WHERE id='$parameter1' ";
        getContentById($sqlQuery);
        break;


}

function getContentById($sqlQuery){
    $requestHandler = new RequestHandler();
    $data = $requestHandler->getMultipleDataFromDatabase($sqlQuery);
    $dataEncoded = json_encode($data, JSON_NUMERIC_CHECK);
    echo $dataEncoded;
}

function getFavourites($sqlQuery){
    $requestHandler = new RequestHandler();
    $data = $requestHandler->getMultipleDataFromDatabase($sqlQuery);

    if(empty($data)){
        echo JsonResponseBuilder::error_response('Sorry but...','You have no existing favourites!', 400);
    }
    else{
        $dataEncoded = json_encode($data);
        echo $dataEncoded;
    }

}

?>