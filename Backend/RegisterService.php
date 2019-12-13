<?php

include 'Users.php';
include 'jsonResponse.php';

$nickname = $_GET['nickname'];
$name = $_GET['name'];
$surname = $_GET['surname'];
$email = $_GET['email'];
$password = $_GET['password'];
$avatar = $_GET['avatar'];

$newUser = new Users(0, $nickname, $name, $surname, $email, $password, $avatar);
$response;

// userExists: bool
$userExists = $newUser->CheckIfUserExists();
if($userExists){
    $response = JsonResponseBuilder::error_response('Sorry but...','User with this email or nickname alreday exists!', 400);
} else{
    $newUser->addNewUser();
    $response = JsonResponseBuilder::success_response($newUser->getUserByEmail());
}

echo $response;

?>