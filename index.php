<?php
session_start();
$_SESSION['user_id'] = 3;


//// Allereerst zorgen dat de "Autoloader" uit vendor opgenomen wordt:
require_once("./vendor/autoload.php");



/// Twig koppelen:
$loader = new \Twig\Loader\FilesystemLoader("./templates");
/// VOOR PRODUCTIE:
/// $twig = new \Twig\Environment($loader), ["cache" => "./cache/cc"]);

/// VOOR DEVELOPMENT:
$twig = new \Twig\Environment($loader, ["debug" => true]);
$twig->addExtension(new \Twig\Extension\DebugExtension());

/******************************/

require_once("lib/database.php");
require_once("lib/recipe.php");
require_once("lib/grocery.php");
$db = new database();
$recipe = new recipe($db->getConnection());
$groceries = new grocery($db->getConnection());






/*
URL:
http://localhost/index.php?gerecht_id=4&action=detail
*/

$recipe_id = isset($_GET["recipe_id"]) ? $_GET["recipe_id"] : "";
$action = isset($_GET["action"]) ? $_GET["action"] : "homepage";
if (isset($_POST['interaction'])) {
    $action = $_POST['interaction'];
};


switch ($action) {

    case "homepage": {
            $data = $recipe->selectRecipes();
            $template = 'homepage.html.twig';
            $title = "homepage";
            break;
        }

    case "detail": {
            $data = $recipe->selectRecipe($recipe_id);
            $template = 'detail.html.twig';
            $title = "detail pagina";
            break;
        }
    case "groceries": {
            $data = $groceries->selectGroceries($_SESSION['user_id']);
            $template = 'groceries.html.twig';
            $title = "grocery list";
            break;
        }

    case "addFavorite": {

            $recipe->addFavorite($_POST["recipe_id"], $_SESSION['user_id']);

            break;
        }
    case "deleteFavorite": {
            $recipe->deleteFavorite($_POST['recipe_id'], $_SESSION['user_id']);
            break;
        }
}

if ($action === "addFavorite" || $action === "deleteFavorite") {
} else {
    $template = $twig->load($template);
    echo $template->render(["title" => $title, "data" => $data]);
}



//echo '<pre>';
//var_dump($data);
