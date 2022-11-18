<?php

require_once 'user.php';

class recipeInfo
{
    private $connection;

    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectPreparations($dish_id)
    {
        $preparations = array();
        $sql = "SELECT * FROM recipe_info WHERE dish_id = $dish_id AND record_type='P'";
        $result = $this->connection->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $preparations[] = $row;
        }
        return $preparations;
    }

    public function selectRatings($dish_id)
    {
        $ratings = array();
        $sql = "SELECT * FROM recipe_info WHERE dish_id = $dish_id AND record_type='R'";
        $result = $this->connection->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $ratings[] = $row;
        }
        return $this->calculateAverageRating($ratings);
    }

    public function calculateAverageRating($ratings)
    {
        $ratingValues = array();
        $averageRating = 0;
        if (count($ratings) > 0) {
            foreach ($ratings as $rating) {
                $ratingValues[] = $rating['nummeric_field'];
            }
            $averageRating = array_sum($ratingValues) / count($ratingValues);
        }
        return $averageRating;
    }

    public function isFavorite($dish_id, $user_id)
    {
        $sql = "SELECT * FROM recipe_info WHERE dish_id = $dish_id AND `user_id` = $user_id AND record_type='F' ";
        $result = $this->connection->query($sql);
        if ($result->num_rows > 0) {
            $favorite = true;
        } else {
            $favorite = false;
        }
        return $favorite;
    }

    public function addFavorite($dish_id, $user_id)
    {
        $sql = "INSERT INTO recipe_info(id, record_type, dish_id, user_id, date, nummeric_field, text_field) VALUES(NULL, 'F', '$dish_id', '$user_id', current_timestamp(), NULL, NULL)";
        if (mysqli_query($this->connection, $sql)) {
            echo "Added to favorites";
        } else {
            echo "Sorry, something went wrong. Try agian later";
        }
    }
    public function deleteFavorite($dish_id, $user_id)
    {
        $sql = "DELETE FROM recipe_info WHERE dish_id = $dish_id AND user_id=$user_id";
        if (mysqli_query($this->connection, $sql)) {
            echo "Deleted from favorites";
        } else {
            echo "Sorry, something went wrong. Try agian later";
        }
    }



    public function selectComments($dish_id)
    {
        $comments = array();
        $sql = "SELECT * FROM recipe_info WHERE dish_id = $dish_id AND record_type='C'";
        $result = $this->connection->query($sql);
        while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
            $comments[] = $row;
        }
        $updatedComments = $this->selectCommentUsernames($comments);
        return $updatedComments;
    }

    public function selectCommentUsernames($comments)
    {
        $userModel = new user($this->connection);
        $updatedComments = array();
        foreach ($comments as $comment) {
            $user = $userModel->selectUserById($comment['user_id']);
            $comment['user'] = $user;
            $updatedComments[] = $comment;
        }
        return $updatedComments;
    }
}
