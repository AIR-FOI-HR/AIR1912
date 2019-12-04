<?php

include 'Users.php';
include 'jsonResponse.php';

$nickname = $_POST['nickname'];
$name = $_POST['name'];
$surname = $_POST['surname'];
$email = $_POST['email'];
$password = $_POST['password'];

$newUser = new Users(0, $nickname, $name, $surname, $email, $password);
$response;

$userExists = $newUser->CheckIfUserExists();
if($userExists){
    $response = json_response('User with this email or password exists!', $code = 400);
}

else{
    $newUser->addNewUser();
    $response = json_response($newUser->getUserByEmail(), $code = 200);
}

echo $response;

?>
