<?php

namespace Config;

class Config
{
    //Nazwa folderu z plikami konfiguracyjnymi
    private static $confdir = "";

    //Nazwa pliku konfiguracyjnego
    private static $confname = "conf.ini";

    public static function loadConfig($section)
    {
        $class = get_called_class();
        $data = parse_ini_file(self::$confdir.self::$confname, true)[$section];
        if(isset($data[$section]))
        {
            $data = $data[$section];
        }
        foreach($data as $key => $value)
        {
            if(property_exists($class, $key))
            {
                $class::$$key = $value;
            }
        }
    }
}
