<?php
require_once 'article.php';
class ingredient
{
    private $connection;

    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectIngredients($recipe_id)
    {
        $ingredients = array();
        $sql = "SELECT * FROM ingredient where recipe_id=$recipe_id";
        $result = $this->connection->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $ingredients[] = $row;
        }
        $updatedIngredients = $this->selectIngredientArticle($ingredients);
        return $updatedIngredients;
    }
    public function selectIngredientArticle($ingredients)
    {
        $articleModel = new article($this->connection);
        $updatedIngredients = array();
        foreach ($ingredients as $ingredient) {
            $article = $articleModel->selectArticleById($ingredient['article_id']);
            $ingredient['article'] = $article;
            $updatedIngredients[] = $ingredient;
        }
        return $updatedIngredients;
    }
}
