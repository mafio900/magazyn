<?php
namespace Models;

use PDO;

class WZ extends PDODatabase
{
    public function __construct()
    {
        $this->table = 'WZ';
        parent::__construct();
    }

    public function insert($NumerWZ, $IdZamowienie, $DataWydania)
    {
        $id = -1;
        $this->testConnection();
        $this->testTable($this->table);
        if(!isset($Nazwa))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'INSERT INTO `'.$this->table.'` (`NumerWZ`, `IdZamowienie`, `DataWydania`)';
            $query .= ' VALUES (:NumerWZ, :IdZamowienie, :DataWydania)';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':NumerWZ', $NumerWZ, PDO::PARAM_STR);
            $stmt->bindValue(':IdZamowienie', $IdZamowienie, PDO::PARAM_INT);
            $stmt->bindValue(':DataWydania', $DataWydania, PDO::PARAM_STR);
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
