<?php
namespace Config\Application;

class Config extends \Config\Config
{
    public static $app_name;
    public static $subdir;
    public static $protocol;
    public static $host;
    public static $port;
    public static $email;
}
Config::loadConfig("Application");
