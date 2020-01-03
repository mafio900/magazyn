<?php
namespace Controllers;

use \Config\Application\Config as Conf;

abstract class Controller
{
    /**
    * funkcja przekierowywująca akcję na inną
    * @param  string $url adres przekierowania
    */
    public function redirect($url)
    {
        if(preg_match('/^http:/', $url) === 1)
            header('location: '.$url);
        else
            header('location: '.Conf::$protocol.$_SERVER["SERVER_NAME"].':'.Conf::$port.'/'.Conf::$subdir.$url);
        exit(0);
    }

    /**
    * zwraca nowy obiekt modelu
    * @param  string $name nazwa typu modelu
    * @return Model obiekt modelu
    */
    public function createModel($name)
    {
        $fullname = 'Models\\'.$name;
        if(!class_exists($fullname))
            throw new \Exceptions\Application();
        return new $fullname();

    }
    /**
    * zwraca nowy obiekt widoku
    * @param  string $name nazwa typu widoku
    * @return View obiekt widoku
    */
    public function createView($name, $controller)
    {
        $fullname = 'Views\\'.$name;
        if(!class_exists($fullname))
            throw new \Exceptions\Application();
        $view = new $fullname($controller);
        $view->setAssets();
        return $view;
    }

    /**
    * sprawdza, czy tablica inputArray posiada ustawione wszystkie klucze
    * @param  array $keys       tablica kluczy
    * @param  array $inputArray sprawdzana tablica
    * @return array             uzupełniona tablica
    */
    protected function check($keys, &$inputArray)
    {
        if(is_array($inputArray)) {
            foreach ($keys as $value) {
                if(!array_key_exists($value, $inputArray))
                    $inputArray[$value] = null;
            }
        }
    }

}
