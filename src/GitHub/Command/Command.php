<?php

namespace GitHub\Command;

abstract Class Command
{
    protected $instruction;
	protected $cApi;
	protected $username;
	protected $project;
	protected $branch;
    public function __construct($instruction)
    {
        $this->instruction = $instruction;
		$this->cApi = new \GitHub\ClientApi;
		$github = new \GitHub\GitHub();
		$this->username = $github->get('username');
		$this->project = $github->get('project');
		$this->branch = $github->get('branch');
    }

	public function __get($name="default")
	{
		return 'command not supported';
	}
}
