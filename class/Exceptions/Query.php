<?php
namespace Exceptions;

/**
 * wyjątek zapytania do bazy danych
 */
class Query extends General
{
    public function __construct($previousException = null)
    {
        parent::__construct($previousException, \Messages\Error::$query);
    }
}
