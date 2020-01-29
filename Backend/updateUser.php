<?php

include 'Users.php';
include 'jsonResponse.php';

$userId = $_GET['idUsers'];
$nickname = $_GET['nickname'];
$name = $_GET['name'];
$surname = $_GET['surname'];
$email = $_GET['email'];
$password = $_GET['password'];
$avatar = $_GET['avatar'];

$newUser = new Users($userId,$nickname, $name, $surname, $email, $password, $avatar);
$response;

// userExists: bool
$userExists = $newUser->CheckIfUserExistsById();
if($userExists){
    $newUser->updateUser();
    $response = JsonResponseBuilder::success_response($newUser->getUserByEmail());
    
} else{
    $response = JsonResponseBuilder::error_response('Sorry but...','Something went wrong with your request!', 400);
}

echo $response;


?>