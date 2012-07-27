<?php

namespace GitHub\Command;

abstract Class Command
{
    protected $instruction;
    public function __construct(\StdClass $instruction)
    {
        $this->instruction = $instruction;
    }

	public function __get()
	{
		return 'command not supported';
	}
}
