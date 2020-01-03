<?php
namespace Exceptions;

/**
 * wyjątek aplikacji
 */
class EmptyValue extends General
{
    public function __construct($previousException = null)
    {
        parent::__construct($previousException, \Messages\Error::$empty);
    }
}
