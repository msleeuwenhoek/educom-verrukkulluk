<?php

class user
{
    private $connection;
    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectUserById($user_id)
    {
        $sql = "SELECT * FROM user where id=$user_id";
        $result = $this->connection->query($sql);
        $user = mysqli_fetch_array($result, MYSQLI_ASSOC);
        return $user;
    }
}
