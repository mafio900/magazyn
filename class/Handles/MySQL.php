<?php
namespace Handles;

use Config\Database\MySQL as MySQLParameters;
use PDO;

class MySQL extends Handle {
    protected function __clone() {}
    protected function __construct() {
        try {
            $this->pdo = new PDO(
                MySQLParameters::$database_type.
                    ':host='.MySQLParameters::$host_name.
                    ';dbname='.MySQLParameters::$database_name.
                    ';port='.MySQLParameters::$port,
                MySQLParameters::$username,
                MySQLParameters::$password
            );
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            $this->pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
        } catch(\PDOException $e) {
            $this->pdo = null;
            throw new \Exceptions\DatabaseConnection($e);
        }
    }
}
