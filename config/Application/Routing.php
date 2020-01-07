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
    ['POST','/zamowienie/edytuj/?', array('controller' => 'Zamowienie', 'action' => 'edit'), 'zamowienie_edit'],
    ['GET','/zamowienie/anuluj/[i:id]?', array('controller' => 'Zamowienie', 'action' => 'cancel'), 'zamowienie_cancel'],

    //konfiguracja WZ
    ['GET','/wz/?', array('controller' => 'WZ', 'action' => 'showAll'), 'wz'],
    ['GET','/wz/[i:id]/?', array('controller' => 'WZ', 'action' => 'ajaxEditForm'), 'wz_form'],

    //konfiguracja PZ
    ['GET','/pz/?', array('controller' => 'PZ', 'action' => 'showAll'), 'pz'],
    ['GET','/pz/editform/[i:id]/?', array('controller' => 'PZ', 'action' => 'showOne'), 'pz_edit_form'],
    ['GET','/pz/done/[i:id]/?', array('controller' => 'PZ', 'action' => 'setIsDone'), 'pz_setIsDone'],
    ['GET','/pz/[i:id]/?', array('controller' => 'PZ', 'action' => 'ajaxEditForm'), 'pz_show_form'],
    ['GET','/pz/usun/[i:id]?', array('controller' => 'PZ', 'action' => 'delete'), 'pz_delete'],
    ['POST','/pz/edytuj/?', array('controller' => 'PZ', 'action' => 'edit'), 'pz_edit'],
    ['GET','/pz/formularz/?', array('controller' => 'PZ', 'action' => 'ajaxAddForm'), 'pz_add_form'],
    ['POST','/pz/dodaj/?', array('controller' => 'PZ', 'action' => 'add'), 'pz_add'],

    //konfiguracja PZTowar
    ['GET','/pztowar/usun/[i:id]?', array('controller' => 'PZTowar', 'action' => 'delete'), 'pztowar_delete'],
    ['POST','/pztowar/usunwiele/[i:id]?', array('controller' => 'PZTowar', 'action' => 'deletePlenty'), 'pztowar_usunwiele'],
    ['POST','/pztowar/edytuj/?', array('controller' => 'PZTowar', 'action' => 'edit'), 'pztowar_edit'],
    ['GET','/pztowar/formularz/[i:id]?', array('controller' => 'PZTowar', 'action' => 'ajaxAddForm'), 'pztowar_form'],
    ['GET','/pztowar/formedytuj/[i:id]?', array('controller' => 'PZTowar', 'action' => 'ajaxEditForm'), 'pztowar_editForm'],
    ['POST','/pztowar/dodaj/?', array('controller' => 'PZTowar', 'action' => 'add'), 'pztowar_add']
    ];
}
