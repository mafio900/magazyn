<?php
namespace Controllers;

class PZTowar extends GlobalController
{
    public function ajaxAddForm($id){
        $this->view->setTemplate('ajaxModals/addPZTowar');
        $model = $this->createModel('PZTowar');
        $result['towary'] = $model->transferByColumn($model->selectAll('Towar'));
        $result['data'] = array('id' => $id);
        return $result;
    }

    public function ajaxEditForm($id)
    {
        $this->view->setTemplate('ajaxModals/editPZTowar');
        $model = $this->createModel('PZTowar');
        $result['data'] = $model->selectOneById($id);
        $result['towary'] = $model->transferByColumn($model->selectAll('Towar'));
        return $result;
    }

    public function delete($id)
    {
        $model = $this->createModel('PZTowar');
        $idPZ = $model->selectOneById($id)['IdPZ'];
        $this->deleteOne($id);
        $this->redirect('pz/editform/'.$idPZ);
    }

    public function deletePlenty($id)
    {
        $this->deleteGiven($_POST['ids']);
        $this->redirect('pz/editform/'.$id);
    }

    public function add()
    {
        $this->check(['id', 'IdTowar', 'Ilosc', 'CenaKupna'], $_POST);
        if($_POST['IdTowar']==''){
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('PZTowar');
        $model->insert($_POST['id'], $_POST['IdTowar'], $_POST['Ilosc'], $_POST['CenaKupna']);
        $this->redirect('pz/editform/'.$_POST['id']);
    }

    public function edit()
    {
        $this->check(['id', 'IdTowar', 'Ilosc', 'CenaKupna'], $_POST);
        if($_POST['IdTowar']=='' && $_POST['id']==''){
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('PZTowar');
        $model->update($_POST['id'], $_POST['IdTowar'], $_POST['Ilosc'], $_POST['CenaKupna']);
        $idPZ = $model->selectOneById($_POST['id'])['IdPZ'];
        $this->redirect("pz/editform/".$idPZ);
    }

}
