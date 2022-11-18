<?php

require_once("lib/database.php");
require_once("lib/user.php");

/// INIT
$db = new database();
$art = new user($db->getConnection());


/// VERWERK 
$data = $art->selectUserById(2);

/// RETURN
var_dump($data);
