<?php

require_once('class.RequestHandler.php');
require_once('jsonResponse.php');

if(isset($_POST['addFavourite'])){
    $userId = $_POST['parameter1'];
    $contentId = $_POST['parameter2'];

    $sqlQuery = "INSERT INTO FavouriteContent (idUser, idContent) VALUES ($userId, $contentId)";
    $isInserted = RequestHandler::addOneRowToDatabase($sqlQuery);

    if($isInserted == false){
        $response = JsonResponseBuilder::error_response('Favourite not inserted', 'Try again later', '400');
        echo $response;
    }
}
?>