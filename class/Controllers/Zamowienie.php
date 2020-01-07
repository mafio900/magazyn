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
        $result['statusObecny'] = $model->selectOneById($result['data']['IdStatus'], 'Status');
        $result['statusNastepny'] = $model->selectOneById($result['data']['IdStatus'] + 1, 'Status');
        $result['users'] = $model->transferByColumn($model->selectAll('Uzytkownik'));
        $result['towary'] = $model->transferByColumn($model->selectAll('Towar'));
        $result['zamowienietowary'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'IdZamowienie =', $id, 'ZamowienieTowar'));
        if($result['data']['IdStatus']=='4')
            $result['currentData'] = date('Y-m-d H:i');

        return $result;
    }

    public function edit()
    {
        $this->check(['id'], $_POST);
        if($_POST['id']=='' || (isset($_POST['DataWydania']) && $_POST['DataWydania']=='')) {
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('Zamowienie');
        $data = $model->selectOneById($_POST['id']);
        $IdStatus = $data['IdStatus']+1;
        if($IdStatus < 6){
            if($IdStatus=='5' && isset($_POST['DataWydania'])){
                $model->update($_POST['id'], $IdStatus, $_POST['DataWydania']);
                $wz = $this->createModel('WZ');
                $numerWZ = 'WZ '.$data['id'].date('/d/m/Y');
                $wz->insert($numerWZ, $data['id'], $_POST['DataWydania']);
            }
            else{
                $model->update($_POST['id'], $IdStatus);
            }
        }
        $this->redirect("zamowienie/");
    }

    public function cancel($id)
    {
        if($id==''){
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('Zamowienie');
        $model->update($id, '6');
        $this->redirect("zamowienie/");
    }

}
