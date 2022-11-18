<?php

require_once("lib/database.php");
require_once("lib/ingredient.php");

/// INIT
$db = new database();
$ingredient = new ingredient($db->getConnection());


/// VERWERK 
$ingredients = $ingredient->selectIngredients(1);

$totalPrice = $ingredient->calculateTotalPrice($ingredients);
echo $totalPrice;


/// RETURN
echo '<pre>';
var_dump($ingredients);
