<?php
session_start();

//setting imaginary logged in user
$_SESSION['user_id'] = 1;



require_once("lib/database.php");
require_once("lib/recipe.php");

/// INIT
$db = new database();
$recipe = new recipe($db->getConnection());


/// VERWERK 
$data = $recipe->selectRecipe(1);




/// RETURN
echo '<pre>';
var_dump($data);
unset($_SESSION['user_id']);
