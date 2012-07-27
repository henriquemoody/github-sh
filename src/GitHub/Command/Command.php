<?php

namespace GitHub\Command;

abstract Class Command
{
    private $instruction;
    public function __construct(\StdClass $instruction)
    {
        $this->instruction = $instruction;
    }
}
