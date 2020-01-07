<?php
namespace Controllers;

class PZ extends GlobalController
{
    public function showAll()
    {
        $this->view->setTemplate('PZ/showAll');
        $this->view->addCSSSet(array('external/datatables',
                                    'external/jquery-timepicker',
                                    'external/select2'));
        $this->view->addJSSet(array('external/datatables',
                                    'external/jquery-timepicker',
                                    'external/select2',
                                    'external/pl',
                                    'dataTables',
                                    'datepicker',
                                    'select2',
                                    'modal/load-modal',
                                    'modal/pz',
                                    'external/jquery.validate',
                                    'external/jquery.validate.add',
                                    'external/date-validator',
                                    'validation',
                                    'validation/pz'));
        $model = $this->createModel('PZ');
        $result['data'] = $model->selectAll();

        return $result;
    }

    public function showOne($id)
    {
        $this->view->setTemplate('PZ/showOne');
        $this->view->addCSSSet(array('external/datatables',
                                    'external/jquery-timepicker',
                                    'external/select2'));
        $this->view->addJSSet(array('external/datatables',
                                    'external/jquery-timepicker',
                                    'external/select2',
                                    'external/pl',
                                    'dataTables',
                                    'select2',
                                    'datepicker',
                                    'external/jquery.validate',
                                    'external/jquery.validate.add',
                                    'external/date-validator',
                                    'validation',
                                    'validation/pz',
                                    'validation/pztowar',
                                    'modal/load-modal',
                                    'modal/pztowar',
                                    'pz'));
        $model = $this->createModel('PZ');
        $result['data'] = $model->selectOneById($id);
        $result['dostawcy'] = $model->transferByColumn($model->selectAll('Dostawca'));
        $result['towary'] = $model->transferByColumn($model->selectAll('Towar'));
        $result['pztowary'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'IdPZ =', $id, 'PZTowar'));

        return $result;
    }

    public function ajaxAddForm($id){
        $this->view->setTemplate('ajaxModals/addPZ');
        $model = $this->createModel('PZ');
        $result['dostawcy'] = $model->transferByColumn($model->selectAll('Dostawca'));
        return $result;
    }

    public function ajaxEditForm($id)
    {
        $this->view->setTemplate('ajaxModals/editPZ');
        $model = $this->createModel('PZ');
        $result['data'] = $model->selectOneById($id);
        $result['towary'] = $model->transferByColumn($model->selectAll('Towar'));
        $result['pztowary'] = $model->transferByColumn($model->selectAllOrderBy(null, 'ASC', 'IdPZ =', $id, 'PZTowar'));

        return $result;
    }

    public function delete($id)
    {
        $model = $this->createModel('PZ');
        $pz = $model->selectOneById($id);
        if($pz['IsDone']=='0')
            $this->deleteOne($id);

        $this->redirect('pz/');
    }

    public function add()
    {
        $this->check(['NumerPZ', 'IdDostawca', 'DataDostawy'], $_POST);
        if($_POST['NumerPZ']=='' && $_POST['IdDostawca']=='' && $_POST['DataDostawy']==''){
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('PZ');
        $dostawca = $model->selectOneById($_POST['IdDostawca'], 'Dostawca');
        $id = $model->insert($_POST['NumerPZ'], $_POST['IdDostawca'], $dostawca['NazwaDostawcy'], $dostawca['Miasto'],
        $dostawca['Ulica'], $dostawca['NrBudynku'], $dostawca['KodPocztowy'], $dostawca['NIP'], $_POST['DataDostawy']);
        $this->redirect('pz/editform/'.$id);
    }


    public function edit()
    {
        $this->check(['id', 'TerminRealizacji', 'KwotaLaczna', 'IdStatus', 'IdKlient', 'IdPracownik'], $_POST);
        if($_POST['TerminRealizacji']=='' && $_POST['KwotaLaczna']=='' && $_POST['IdStatus']=='' && $_POST['IdKlient']=='' && $_POST['IdPracownik']=='' && $_POST['id']=='')
        {
            throw new \Exceptions\EmptyValue;
        }
        $model = $this->createModel('Rezerwacja');
        $model->update($_POST['id'], $_POST['TerminRealizacji'], $_POST['KwotaLaczna'], $_POST['IdStatus'], $_POST['IdKlient'], $_POST['IdPracownik']);
        $this->redirect("rezerwacja/".$_POST['id']);
    }

}
