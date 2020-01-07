<?php
namespace Models;

use PDO;

class PZTowar extends PDODatabase
{
    public function __construct()
    {
        $this->table = 'PZTowar';
        parent::__construct();
    }

    public function insert($IdPZ, $IdTowar, $Ilosc, $CenaKupna)
    {
        $id = -1;
        $this->testConnection();
        $this->testTable($this->table);
        if(!isset($IdPZ))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'INSERT INTO `'.$this->table.'` (`IdPZ`, `IdTowar`, `Ilosc`, `CenaKupna`)';
            $query .= ' VALUES (:IdPZ, :IdTowar, :Ilosc, :CenaKupna)';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':IdPZ', $IdPZ, PDO::PARAM_INT);
            $stmt->bindValue(':IdTowar', $IdTowar, PDO::PARAM_INT);
            $stmt->bindValue(':Ilosc', $Ilosc, PDO::PARAM_STR);
            $stmt->bindValue(':CenaKupna', $CenaKupna, PDO::PARAM_STR);
            if($stmt->execute()) {
                $id = $this->pdo->lastInsertId();
            }
            $stmt->closeCursor();
        } catch(\PDOException $e) {
            throw new \Exceptions\Query($e);
        }
        return $id;
    }

    public function update($id, $IdTowar, $Ilosc, $CenaKupna)
    {
        $this->testConnection();
        $this->testTable($this->table);

        if(!isset($id))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'UPDATE `'.$this->table.'`';
            $query .= ' SET IdTowar = :IdTowar,
                        Ilosc = :Ilosc,
                        CenaKupna = :CenaKupna';
            $query .= ' WHERE id = :id';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':IdTowar', $IdTowar, PDO::PARAM_INT);
            $stmt->bindValue(':Ilosc', $Ilosc, PDO::PARAM_STR);
            $stmt->bindValue(':CenaKupna', $CenaKupna, PDO::PARAM_STR);
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
