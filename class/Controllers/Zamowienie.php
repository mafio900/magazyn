<?php
namespace Controllers;

class Zamowienie extends GlobalController
{
    public function showAll()
    {
        $this->view->setTemplate('Zamowienie/showAll');
        $this->view->addCSSSet(array('external/datatables', 'external/jquery-timepicker', 'external/select2'));
        $this->view->addJSSet(array('external/datatables',
                                    'external/jquery-timepicker',
                                    'dataTables',
                                    'external/select2',
                                    'external/pl',
                                    'datepicker',
                                    'select2',
                                    'modal/load-modal',
                                    'modal/zamowienie',
                                    'external/jquery.validate',
                                    'external/jquery.validate.add',
                                    'external/date-validator',
                                    'validation',
                                    'validation/zamowienie'));

        $model = $this->createModel('Zamowienie');
        $result['data'] = $model->selectAll();
        $result['statusy'] = $model->transferByColumn($model->selectAll('Status'));
        $result['users'] = $model->transferByColumn($model->selectAll('Uzytkownik'));

        return $result;
    }

    public function ajaxEditForm($id)
    {
        $this->view->setTemplate('ajaxModals/editZamowienie');
        $model = $this->createModel('Zamowienie');
        $result['data'] = $model->selectOneById($id);
        if($result['data']['IdStatus']<='4'){
            $result['statusy'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'id BETWEEN ', $result['data']['IdStatus'].' AND 4', 'Status'));
        }
        else {
            $result['statusy'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'id =', '5', 'Status'));
        }
        $result['users'] = $model->transferByColumn($model->selectAll('Uzytkownik'));
        $result['towary'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'IdZamowienie =', $id, 'ZamowienieTowar'));
        if($result['data']['IdStatus']=='4')
            $result['currentData'] = date('Y-m-d H:i');

        return $result;
    }

    public function delete($id)
    {
        $this->deleteOne($id);
        $this->redirect('zamowienie/');
    }

    public function deletePlenty()
    {
        $this->deleteGiven($_POST['ids']);
        $this->redirect('zamowienie/');
    }

    public function add()
    {
        $this->check(['Nazwa', 'CenaSprzedazy', 'IdJednostkaMiary', 'ProcentVat', 'Dzial', 'Regal', 'Polka', 'StanMagazynowy', 'StanMax', 'StanMin', 'StanDysponowany'], $_POST);
        if($_POST['Nazwa']==''){
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('Towar');
        $model->insert($_POST['Nazwa'],
        $_POST['CenaSprzedazy'], $_POST['IdJednostkaMiary'], $_POST['ProcentVat'], $_POST['Dzial'],
        $_POST['Regal'], $_POST['Polka'], $_POST['StanMagazynowy'], $_POST['StanMax'], $_POST['StanMin'], $_POST['StanDysponowany']);
        $this->redirect('zamowienie/');
    }

    public function edit()
    {
        $this->check(['id', 'Nazwa', 'CenaSprzedazy', 'IdJednostkaMiary', 'ProcentVat', 'Dzial', 'Regal', 'Polka', 'StanMagazynowy', 'StanMax', 'StanMin', 'StanDysponowany'], $_POST);
        if($_POST['Nazwa']=='' && $_POST['id']=='')
        {
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('Towar');
        $model->update($_POST['id'], $_POST['Nazwa'],
        $_POST['CenaSprzedazy'], $_POST['IdJednostkaMiary'], $_POST['ProcentVat'], $_POST['Dzial'],
        $_POST['Regal'], $_POST['Polka'], $_POST['StanMagazynowy'], $_POST['StanMax'], $_POST['StanMin'], $_POST['StanDysponowany']);
        $this->redirect("zamowienie/");
    }

}
