<?php
namespace Controllers;

/**
 * kontroler bazowy dla innych kontrolerów z uniwersalnymi metodami
 */
class GlobalController extends Controller
{
    /**
    * Usunięcie encji
    * @param  int    $id identyfikator encji
    */
    public function deleteOne($id)
    {
        $className = substr(get_class($this), strrpos(get_class($this),'\\') + 1);
        $model = $this->createModel($className);
        $counter = -1;
        if(isset($id)) {
            $counter = $model->deleteOneById($id);
        }
    }

    public function deleteGiven($ids)
    {
        if(isset($ids)) {
            foreach($ids as $id)
            {
                $this->deleteOne($id);
            }
        }
    }

    public function ajaxEditForm($id){
      $className = substr(get_class($this), strrpos(get_class($this),'\\') + 1);
      if(isset($id)){
        $this->view->setTemplate('ajaxModals/edit'.$className);
        $model = $this->createModel($className);
        $result['data'] = $model->selectOneById($id);
        if(count($result['data']) === 0)
          throw new \Exceptions\Application();
        return $result;
      } else {
        throw new \Exceptions\EmptyValue();
      }
    }

    public function ajaxAddForm($id){
        $className = substr(get_class($this), strrpos(get_class($this),'\\') + 1);
        $this->view->setTemplate('ajaxModals/add'.$className);
    }
}
