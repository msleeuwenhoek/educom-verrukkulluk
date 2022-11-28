<?php

require_once 'ingredient.php';
require_once 'recipe_info.php';
require_once 'user.php';
require_once 'kitchen_type.php';


class recipe
{
    private $connection;

    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectRecipes()
    {
        $recipes = array();
        $updatedRecipes = array();
        $sql = "SELECT * FROM recipe";
        $result = $this->connection->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $recipes[] = $row;
        }

        foreach ($recipes as $recipe) {
            $recipeData = $this->selectRecipe($recipe['id']);
            $updatedRecipes[] = $recipeData;
        }
        return $updatedRecipes;
    }

    public function selectRecipe($recipe_id)
    {
        $sql = "SELECT * FROM recipe WHERE id=$recipe_id";
        $result = $this->connection->query($sql);
        $recipe = mysqli_fetch_array($result, MYSQLI_ASSOC);

        // Checking if a user is logged in
        $current_user = null;
        if (isset($_SESSION['user_id'])) {
            $current_user = $this->selectUser($_SESSION['user_id']);
        }

        // Retrieving associated data
        $ingredients = $this->selectIngredients($recipe['id']);
        $rating = $this->selectRating($recipe['id']);
        $preparations = $this->selectPreparations($recipe['id']);
        $comments = $this->selectComments($recipe['id']);
        $totalPrice = $this->calculateTotalPrice($ingredients);
        $kitchen = $this->selectKitchenType($recipe['kitchen_id']);
        $type = $this->selectKitchenType($recipe['type_id']);
        $calories = $this->calculateTotalCalories($ingredients);

        if ($current_user !== null) {
            $isFavorite = $this->checkIfFavorite($recipe['id'], $current_user['id']);
        } else {
            $isFavorite = false;
        }





        // Returning all associated data
        return array('recipe' => $recipe, 'ingredients' => $ingredients, 'rating' => $rating, 'preparations' => $preparations, 'comments' => $comments, 'isFavorite' => $isFavorite, 'total_price' => $totalPrice, 'kitchen' => $kitchen, 'type' => $type, 'calories' => $calories, 'current_user' => $current_user);
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
        $totalPrice = number_format(array_sum($ingredientPrices), 2, ",", ".");
        return $totalPrice;
    }

    private function calculateTotalCalories($ingredients)
    {
        $ingredientCalories = array();
        foreach ($ingredients as $ingredient) {
            if ($ingredient['article']['unit'] === "pieces") {
                $ingredientCalorie = $ingredient['article']['calories'] * $ingredient['amount'];
            } elseif ($ingredient['article']['unit'] === "kilo") {
                $ingredientCalorie = $ingredient['article']['calories'] * 10 * $ingredient['amount'];
            } else {
                $ingredientCalorie = $ingredient['article']['calories'] / 100 * $ingredient['amount'];
            }
            $ingredientCalories[] = $ingredientCalorie;
        }
        $totalCalories = round(array_sum($ingredientCalories));
        return $totalCalories;
    }

    private function selectKitchenType($kitchen_type_id)
    {
        $kitchenTypeModel = new kitchen_type($this->connection);
        $kitchen_type = $kitchenTypeModel->selectKitchenTypeById($kitchen_type_id);
        return $kitchen_type;
    }

    public function addFavorite($recipe_id, $user_id)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $recipeInfoModel->addFavorite($recipe_id, $user_id);
    }

    public function deleteFavorite($recipe_id, $user_id)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $recipeInfoModel->deleteFavorite($recipe_id, $user_id);
    }

    public function updateRating($recipe_id, $rating, $user_id)
    {
        $recipeInfoModel = new recipeInfo($this->connection);
        $recipeInfoModel->updateRating($recipe_id, $rating, $user_id);
    }
}
