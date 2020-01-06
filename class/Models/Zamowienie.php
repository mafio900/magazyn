<?php
namespace Models;

use PDO;

class Zamowienie extends PDODatabase
{
    public function __construct()
    {
        $this->table = 'Zamowienie';
        parent::__construct();
    }

    public function update($id, $IdStatus, $DataWydania = null)
    {
        $this->testConnection();
        $this->testTable($this->table);

        if(!isset($id) && !isset($name))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'UPDATE `'.$this->table.'`';
            $query .= ' SET IdStatus = :IdStatus';
            if($DataWydania){
                $query = ', DataWydania = :DataWydania';
            }
            $query .= ' WHERE id = :id';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':IdStatus', $IdStatus, PDO::PARAM_INT);
            if($DataWydania){
                $stmt->bindValue(':DataWydania', $DataWydania, PDO::PARAM_STR);
            }
            $stmt->bindValue(':id', $id, PDO::PARAM_INT);
            if($stmt->execute()) {
                $id = $this->pdo->lastInsertId();
            }
            $stmt->closeCursor();
        } catch(\PDOException $e) {
            throw new \Exceptions\Query($e);
        }
        return $id;
    }
}
