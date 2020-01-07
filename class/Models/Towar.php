<?php
namespace Models;

use PDO;

class Towar extends PDODatabase
{
    public function __construct()
    {
        $this->table = 'Towar';
        parent::__construct();
    }

    public function insert($Nazwa, $CenaSprzedazy, $IdJednostkaMiary, $ProcentVat, $Dzial, $Regal, $Polka, $StanMagazynowy, $StanMax, $StanMin, $StanDysponowany)
    {
        $id = -1;
        $this->testConnection();
        $this->testTable($this->table);
        if(!isset($Nazwa))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'INSERT INTO `'.$this->table.'` (`Nazwa`, `CenaSprzedazy`, `IdJednostkaMiary`, `ProcentVat`, `Dzial`, `Regal`, `Polka`, `StanMagazynowy`, `StanMax`, `StanMin`, `StanDysponowany`)';
            $query .= ' VALUES (:Nazwa, :CenaSprzedazy, :IdJednostkaMiary, :ProcentVat, :Dzial, :Regal, :Polka, :StanMagazynowy, :StanMax, :StanMin, :StanDysponowany)';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':Nazwa', $Nazwa, PDO::PARAM_STR);
            $stmt->bindValue(':CenaSprzedazy', $CenaSprzedazy, PDO::PARAM_STR);
            $stmt->bindValue(':IdJednostkaMiary', $IdJednostkaMiary, PDO::PARAM_INT);
            $stmt->bindValue(':ProcentVat', $ProcentVat, PDO::PARAM_STR);
            $stmt->bindValue(':Dzial', $Dzial, PDO::PARAM_STR);
            $stmt->bindValue(':Regal', $Regal, PDO::PARAM_STR);
            $stmt->bindValue(':Polka', $Polka, PDO::PARAM_STR);
            $stmt->bindValue(':StanMagazynowy', $StanMagazynowy, PDO::PARAM_STR);
            $stmt->bindValue(':StanMax', $StanMax, PDO::PARAM_STR);
            $stmt->bindValue(':StanMin', $StanMin, PDO::PARAM_STR);
            $stmt->bindValue(':StanDysponowany', $StanDysponowany, PDO::PARAM_STR);
            if($stmt->execute()) {
                $id = $this->pdo->lastInsertId();
            }
            $stmt->closeCursor();
        } catch(\PDOException $e) {
            throw new \Exceptions\Query($e);
        }
        return $id;
    }

    public function update($id, $Nazwa, $CenaSprzedazy, $IdJednostkaMiary, $ProcentVat, $Dzial, $Regal, $Polka, $StanMagazynowy, $StanMax, $StanMin, $StanDysponowany)
    {
        $this->testConnection();
        $this->testTable($this->table);

        if(!isset($id) && !isset($Nazwa))
            throw new \Exceptions\EmptyValue;
        try	{
            $query = 'UPDATE `'.$this->table.'`';
            $query .= ' SET Nazwa = :Nazwa,
                        CenaSprzedazy = :CenaSprzedazy,
                        IdJednostkaMiary = :IdJednostkaMiary,
                        ProcentVat = :ProcentVat,
                        Dzial = :Dzial,
                        Regal = :Regal,
                        Polka = :Polka,
                        StanMagazynowy = :StanMagazynowy,
                        StanMax = :StanMax,
                        StanMin = :StanMin,
                        StanDysponowany = :StanDysponowany';
            $query .= ' WHERE id = :id';
            $stmt = $this->pdo->prepare($query);

            $stmt->bindValue(':Nazwa', $Nazwa, PDO::PARAM_STR);
            $stmt->bindValue(':CenaSprzedazy', $CenaSprzedazy, PDO::PARAM_STR);
            $stmt->bindValue(':IdJednostkaMiary', $IdJednostkaMiary, PDO::PARAM_INT);
            $stmt->bindValue(':ProcentVat', $ProcentVat, PDO::PARAM_STR);
            $stmt->bindValue(':Dzial', $Dzial, PDO::PARAM_STR);
            $stmt->bindValue(':Regal', $Regal, PDO::PARAM_STR);
            $stmt->bindValue(':Polka', $Polka, PDO::PARAM_STR);
            $stmt->bindValue(':StanMagazynowy', $StanMagazynowy, PDO::PARAM_STR);
            $stmt->bindValue(':StanMax', $StanMax, PDO::PARAM_STR);
            $stmt->bindValue(':StanMin', $StanMin, PDO::PARAM_STR);
            $stmt->bindValue(':StanDysponowany', $StanDysponowany, PDO::PARAM_STR);
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
