<?php
namespace Models;

use PDO;

class PZ extends PDODatabase
{
    public function __construct()
    {
        $this->table = 'PZ';
        parent::__construct();
    }

    public function insert($NumerPZ, $IdDostawca, $NazwaDostawcy, $Miasto, $Ulica, $NrBudynku, $KodPocztowy, $NIP, $DataDostawy)
    {
        $array = str_split($DataDostawy);
        $NumerPZ = null;
        foreach ($array as $char){
            if($char != " ")
                $NumerPZ .= $char;
            else
                break;
        }
        $NumerPZ = str_replace('-', '/', $NumerPZ);

        $id = -1;
        $this->testConnection();
        $this->testTable($this->table);
        if(!isset($NumerPZ) && !isset($IdDostawca) && !isset($NazwaDostawcy)
        && !isset($Miasto) && !isset($Ulica) && !isset($NrBudynku)
        && !isset($KodPocztowy) && !isset($NIP) && !isset($DataDostawy))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'INSERT INTO `'.$this->table.'` (`NumerPZ`, `IdDostawca`, `NazwaDostawcy`, `Miasto`, `Ulica`, `NrBudynku`, `KodPocztowy`, `NIP`, `DataDostawy`)';
            $query .='  VALUES (:NumerPZ, :IdDostawca, :NazwaDostawcy, :Miasto, :Ulica, :NrBudynku, :KodPocztowy, :NIP, :DataDostawy)';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':NumerPZ', $NumerPZ, PDO::PARAM_STR);
            $stmt->bindValue(':IdDostawca', $IdDostawca, PDO::PARAM_INT);
            $stmt->bindValue(':NazwaDostawcy', $NazwaDostawcy, PDO::PARAM_STR);
            $stmt->bindValue(':Miasto', $Miasto, PDO::PARAM_STR);
            $stmt->bindValue(':Ulica', $Ulica, PDO::PARAM_STR);
            $stmt->bindValue(':NrBudynku', $NrBudynku, PDO::PARAM_STR);
            $stmt->bindValue(':KodPocztowy', $KodPocztowy, PDO::PARAM_STR);
            $stmt->bindValue(':NIP', $NIP, PDO::PARAM_STR);
            $stmt->bindValue(':DataDostawy', $DataDostawy, PDO::PARAM_STR);
            if($stmt->execute()) {
                $id = $this->pdo->lastInsertId();
            }
            $stmt->closeCursor();
        } catch(\PDOException $e) {
            throw new \Exceptions\Query($e);
        }

        $NumerPZ = 'PZ '.$id.'/'.$NumerPZ;
        $this->update($id, $NumerPZ, $IdDostawca, $NazwaDostawcy, $Miasto, $Ulica, $NrBudynku, $KodPocztowy, $NIP, $DataDostawy);
        return $id;
    }

    public function update($id, $NumerPZ, $IdDostawca, $NazwaDostawcy, $Miasto, $Ulica, $NrBudynku, $KodPocztowy, $NIP, $DataDostawy)
    {
        $this->testConnection();
        $this->testTable($this->table);

        if(!isset($id) && !isset($NumerPZ) && !isset($IdDostawca) && !isset($NazwaDostawcy)
        && !isset($Miasto) && !isset($Ulica) && !isset($NrBudynku)
        && !isset($KodPocztowy) && !isset($NIP) && !isset($DataDostawy))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'UPDATE `'.$this->table.'`';
            $query .= ' SET NumerPZ = :NumerPZ, IdDostawca = :IdDostawca, NazwaDostawcy = :NazwaDostawcy,
                        Miasto = :Miasto, Ulica = :Ulica, NrBudynku = :NrBudynku, KodPocztowy = :KodPocztowy, NIP = :NIP, DataDostawy = :DataDostawy';
            $query .= ' WHERE id = :id';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':NumerPZ', $NumerPZ, PDO::PARAM_STR);
            $stmt->bindValue(':IdDostawca', $IdDostawca, PDO::PARAM_INT);
            $stmt->bindValue(':NazwaDostawcy', $NazwaDostawcy, PDO::PARAM_STR);
            $stmt->bindValue(':Miasto', $Miasto, PDO::PARAM_STR);
            $stmt->bindValue(':Ulica', $Ulica, PDO::PARAM_STR);
            $stmt->bindValue(':NrBudynku', $NrBudynku, PDO::PARAM_STR);
            $stmt->bindValue(':KodPocztowy', $KodPocztowy, PDO::PARAM_STR);
            $stmt->bindValue(':NIP', $NIP, PDO::PARAM_STR);
            $stmt->bindValue(':DataDostawy', $DataDostawy, PDO::PARAM_STR);
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

    public function setIsDone($id)
    {
        $this->testConnection();
        $this->testTable($this->table);

        if(!isset($id))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'UPDATE `'.$this->table.'`';
            $query .= ' SET IsDone = true';
            $query .= ' WHERE id = :id';
            $stmt = $this->pdo->prepare($query);

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
