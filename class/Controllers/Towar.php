<?php
namespace Controllers;

class Towar extends GlobalController
{
    public function showAll()
    {
        $this->view->setTemplate('Towar/showAll');
        $this->view->addCSSSet(array('external/datatables', 'external/select2'));
        $this->view->addJSSet(array('external/datatables',
                                    'dataTables',
                                    'external/select2',
                                    'external/pl',
                                    'select2',
                                    'modal/load-modal',
                                    'modal/towar',
                                    'external/jquery.validate',
                                    'external/jquery.validate.add',
                                    'external/jquery.validate.polish',
                                    'validation',
                                    'validation/towar'));

        $model = $this->createModel('Towar');
        $result['data'] = $model->selectAll();
        $result['jednostki'] = $model->transferByColumn($model->selectAll('JednostkaMiary'));

        return $result;
    }

    public function ajaxAddForm($id){
        $this->view->setTemplate('ajaxModals/addTowar');
        $model = $this->createModel('Towar');
        $result['jednostki'] = $model->transferByColumn($model->selectAll('JednostkaMiary'));
        return $result;
    }

    public function ajaxEditForm($id)
    {
        $this->view->setTemplate('ajaxModals/editTowar');
        $model = $this->createModel('Towar');
        $result['data'] = $model->selectOneById($id);
        $result['jednostki'] = $model->transferByColumn($model->selectAll('JednostkaMiary'));
        return $result;
    }

    public function delete($id)
    {
        $this->deleteOne($id);
        $this->redirect('towar/');
    }

    public function deletePlenty()
    {
        $this->deleteGiven($_POST['ids']);
        $this->redirect('towar/');
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
        $this->redirect('towar/');
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
        $this->redirect("towar/");
    }

}
