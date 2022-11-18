<?php

class article
{

    private $connection;

    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectArticleById($article_id)
    {

        $sql = "select * from article where id=$article_id";

        $result = mysqli_query($this->connection, $sql);
        $article = mysqli_fetch_array($result, MYSQLI_ASSOC);

        return ($article);
    }
}
