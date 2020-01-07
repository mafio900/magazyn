<?php
namespace Controllers;

class WZ extends GlobalController
{
    public function showAll()
    {
        $this->view->setTemplate('WZ/showAll');
        $this->view->addCSSSet(array('external/datatables'));
        $this->view->addJSSet(array('external/datatables',
                                    'dataTables',
                                    'modal/load-modal',
                                    'modal/wz'));

        $model = $this->createModel('WZ');
        $result['data'] = $model->selectAll();
        $result['zamowienia'] = $model->transferByColumn($model->selectAll('Zamowienie'));
        $result['users'] = $model->transferByColumn($model->selectAll('Uzytkownik'));

        return $result;
    }

    public function ajaxEditForm($id)
    {
        $this->view->setTemplate('ajaxModals/editWZ');
        $model = $this->createModel('WZ');
        $result['data'] = $model->selectOneById($id);
        $result['zamowienia'] = $model->transferByColumn($model->selectAll('Zamowienie'));
        $result['users'] = $model->transferByColumn($model->selectAll('Uzytkownik'));
        $result['towary'] = $model->transferByColumn($model->selectAll('Towar'));
        $result['zamowienietowary'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'IdZamowienie =', $result['data']['IdZamowienie'], 'ZamowienieTowar'));

        return $result;
    }

}
