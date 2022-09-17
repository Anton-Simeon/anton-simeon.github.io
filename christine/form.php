<?php
header('Content-Type: text/html; charset=utf-8');



$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$message = $_POST['message'];
$response_to_email = $_POST['response_to_email'];
$response_to_phone = $_POST['response_to_phone'];

$name = htmlspecialchars($name);
$email = htmlspecialchars($email);
$phone = htmlspecialchars($phone);
$message = htmlspecialchars($message);
$response_to_email = htmlspecialchars($response_to_email);
$response_to_phone = htmlspecialchars($response_to_phone);

$name = urldecode($name);
$email = urldecode($email);
$phone = urldecode($phone);
$message = urldecode($message);
$response_to_email = urldecode($response_to_email);
$response_to_phone = urldecode($response_to_phone);

$name = trim($name);
$email = trim($email);
$phone = trim($phone);
$message = trim($message);
$response_to_email = trim($response_to_email);
$response_to_phone = trim($response_to_phone);


if (strlen($response_to_email)  < 1) {
  $response_to_email = "nein";
}else {
	$response_to_email = "ja";
}

if (strlen($response_to_phone)  < 1) {
  $response_to_phone = "nein";
}else {
	$response_to_phone = "ja";
}


$html = "Name:".$name."\r\nEmail: ".$email."\r\nTelefonnumer: ".$phone."\r\nNachricht: ".$message."\r\nAntwort per Email: ".$response_to_email."\r\nBitte um Ruckruf: ".$response_to_phone;


if (mail("rolltreff@haut-haar.eu", "Holen Sie sich einen Termin", $html ,"From: rolltreff@haut-haar.eu \r\n")){
	echo "done";
} else {
    echo "error";
}?>