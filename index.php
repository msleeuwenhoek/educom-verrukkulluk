<?php

require_once("lib/database.php");
require_once("lib/recipe_info.php");

/// INIT
$db = new database();
$recipeInfo = new recipeInfo($db->getConnection());


/// VERWERK 
$data = $recipeInfo->selectPreparations(1, 1);

if ($recipeInfo->isFavorite(1, 1)) {
    echo "favorite recipe <br/>";
}
$comments = $recipeInfo->selectComments(1);
$rating = $recipeInfo->selectRatings(1);
echo 'rating: ' . $rating . '<br/>';

//$recipeInfo->addFavorite(4, 1);
$recipeInfo->deleteFavorite(4, 1);
echo '<br/>';

/// RETURN
echo 'preparations:';
echo '<pre>';
var_dump($data);

var_dump($comments);
echo $comments[0]['user']['user_name'];
