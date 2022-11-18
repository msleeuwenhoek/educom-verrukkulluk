<?php

require_once("lib/database.php");
require_once("lib/kitchen_type.php");

/// INIT
$db = new database();
$art = new kitchen_type($db->getConnection());


/// VERWERK 
$data = $art->selectKitchenTypeById(5);

/// RETURN
var_dump($data);
