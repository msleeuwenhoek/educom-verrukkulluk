<?php

require_once 'ingredient.php';
require_once 'recipe_info.php';
require_once 'user.php';



class recipe
{
    private $connection;

    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectRecipe($recipe_id)
    {
        $sql = "SELECT * FROM recipe WHERE id=$recipe_id";
        $result = $this->connection->query($sql);
        $recipe = mysqli_fetch_array($result, MYSQLI_ASSOC);

        // Checking if a user is logged in
        if (isset($_SESSION['user_id'])) {
            $current_user = $this->selectUser($_SESSION['user_id']);
        }
        // Retrieving associated data
        $ingredients = $this->selectIngredients($recipe['id']);
        $rating = $this->selectRating($recipe['id']);
        $preparations = $this->selectPreparations($recipe['id']);
        $comments = $this->selectComments($recipe['id']);
        $totalPrice = $this->calculateTotalPrice($ingredients);

        if (isset($current_user)) {
            $isFavorite = $this->checkIfFavorite($recipe['id'], $current_user['id']);
        } else {
            $isFavorite = false;
        }
        // Returning all associated data
        return array('recipe' => $recipe, 'ingredients' => $ingredients, 'rating' => $rating, 'preparations' => $preparations, 'comments' => $comments, 'isFavorite' => $isFavorite, 'total_price' => $totalPrice);
    }

    private function selectIngredients($recipe_id)
    {
        $ingredientModel = new ingredient($this->connection);
        $ingredients = $ingredientModel->selectIngredients($recipe_id);
        return $ingredients;
    }

    private function selectRating($recipe_id)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $rating = $recipeInfoModel->calculateAverageRating($recipe_id);
        return $rating;
    }

    private function selectPreparations($recipe_id)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $preparations = $recipeInfoModel->selectPreparations($recipe_id);
        return $preparations;
    }

    private function selectComments($recipe_id)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $comments = $recipeInfoModel->selectComments($recipe_id);
        return $comments;
    }

    private function selectUser($user_id)
    {
        $userModel = new user($this->connection);
        $user = $userModel->selectUserById($user_id);
        return $user;
    }

    private function checkIfFavorite($recipe_id, $current_user)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $isFavorite = $recipeInfoModel->isFavorite($recipe_id, $current_user);
        return $isFavorite;
    }

    private function calculateTotalPrice($ingredients)
    {
        $ingredientPrices = array();
        foreach ($ingredients as $ingredient) {
            $ingredientPrice = $ingredient['article']['price'] / $ingredient['article']['packaging'] * $ingredient['amount'];
            $ingredientPrices[] = $ingredientPrice;
        }
        $totalPrice = round(array_sum($ingredientPrices), 2);
        return $totalPrice;
    }
}
