<?php
session_start();

//setting imaginary logged in user
$_SESSION['user_id'] = 1;



require_once("lib/database.php");
require_once("lib/grocery.php");

/// INIT
$db = new database();
$grocery = new grocery($db->getConnection());


/// VERWERK 
$groceries = $grocery->selectGroceries(1);




/// RETURN
echo '<pre>';
var_dump($groceries);

unset($_SESSION['user_id']);
