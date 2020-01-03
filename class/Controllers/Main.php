<?php

namespace Controllers;

class Main extends GlobalController
{
    function __construct()
    {
        try {
            // Routing aplikacji
            $router = \Tools\Router::getRouter();
            $match = $router->match();
            // Kontroler / akcja / parametr_id
            $controller = isset($match['target']['controller'])  ? $match['target']['controller'] : 'JednostkaMiary';
            $action     = isset($match['target']['action'])      ? $match['target']['action']     : 'showAll';
            $id         = isset($match['params']['id'])          ? $match['params']['id']         : null;
            // Dodanie do nazwy kontrolera przestrzeni nazw
            $fullController = 'Controllers\\'.$controller;
            // Utworzenie kontrolera (jeśli istnieje)
            if (!class_exists($fullController)) {
                throw new \Exceptions\Application();
            }
            $appController = new $fullController();
            // Utworzenie obiektu widoku

            $appController->view = $this->createView('AppView', $controller);

            // Sprawdzamy, czy akcja kontrolera istnieje
            if (!method_exists($appController, $action)) {
                throw new \Exceptions\Application();
            }
            // Uruchamiamy akcję kontrolera
            $result = $appController->$action($id);
            //d($result);
            // Przekazujemy zwrócone dane do widoku
            $appController->view->setData($result);
            // Renderujemy widok
            $appController->view->render();
        } catch(\Exceptions\DatabaseConnection $e) {
            d($e);
            //$this->redirect('404.html');
        } catch(\Exceptions\General $e) {
            d($e);
            //$this->redirect('404.html');
        } catch(\Exception $e) {
            //$this->redirect('404.html');
        }
    }

}
