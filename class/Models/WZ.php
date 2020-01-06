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

    public function insert($IdZamowienie, $NumerWZ, $DataWydania)
    {
        $id = -1;
        $this->testConnection();
        $this->testTable($this->table);
        if(!isset($Nazwa))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'INSERT INTO `'.$this->table.'` (`IdZamowienie`, `NumerWZ`, `DataWydania`)';
            $query .= ' VALUES (:IdZamowienie, :NumerWZ, :DataWydania)';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':IdZamowienie', $IdZamowienie, PDO::PARAM_INT);
            $stmt->bindValue(':NumerWZ', $NumerWZ, PDO::PARAM_STR);
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
