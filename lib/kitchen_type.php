<?php

class kitchen_type
{
    private $connection;

    public function __construct($connection)
    {
        $this->connection = $connection;
    }

    public function selectKitchenTypeById($kitchen_type_id)
    {
        $sql = "SELECT * FROM kitchen_type WHERE id = $kitchen_type_id";
        $result = $this->connection->query($sql);
        $kitchen_type = mysqli_fetch_array($result, MYSQLI_ASSOC);
        return $kitchen_type;
    }
}
