<?php
namespace Config\Application;

/**
* Klasa konfiguracyjna przyjaznych adresów
*/
final class Routing {
    public static $routes = [
    ['GET','/', array('controller' => 'Towar', 'action' => 'showAll'), 'home'],

    //konfiguracja Towar
    ['GET','/towar/?', array('controller' => 'Towar', 'action' => 'showAll'), 'towar'],
    ['GET','/towar/[i:id]/?', array('controller' => 'Towar', 'action' => 'ajaxEditForm'), 'towar_edit_form'],
    ['GET','/towar/usun/[i:id]?', array('controller' => 'Towar', 'action' => 'delete'), 'towar_delete'],
    ['POST','/towar/usunwiele/?', array('controller' => 'Towar', 'action' => 'deletePlenty'), 'towar_delete_selected'],
    ['POST','/towar/edytuj/?', array('controller' => 'Towar', 'action' => 'edit'), 'towar_edit'],
    ['GET','/towar/formularz/?', array('controller' => 'Towar', 'action' => 'ajaxAddForm'), 'towar_add_form'],
    ['POST','/towar/dodaj/?', array('controller' => 'Towar', 'action' => 'add'), 'towar_add'],

    //konfiguracja Zamowienie
    ['GET','/zamowienie/?', array('controller' => 'Zamowienie', 'action' => 'showAll'), 'zamowienie'],
    ['GET','/zamowienie/[i:id]/?', array('controller' => 'Zamowienie', 'action' => 'ajaxEditForm'), 'zamowienie_edit_form'],
    ['POST','/zamowienie/edytuj/?', array('controller' => 'Zamowienie', 'action' => 'edit'), 'zamowienie_edit']
    ];
}
