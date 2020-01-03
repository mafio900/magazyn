<?php

namespace Config\Database;

class MySQL extends \Config\Config
{
    public static $database_name;
    public static $host_name;
    public static $database_type;
    public static $port;
    public static $username;
    public static $password;
}
MySQL::loadConfig("MySQL");
