<?php
namespace GitHub\Command;

class Issue extends Command
{
	
	public function __get($name="default")
	{
		$p = $this->instruction->parameters;
		if ($p[0] == (integer) $p[0]) {
			return $this->getOne($p[0]);
		}

			var_dump($this->instruction);
	}
	public function getOne($id)
	{
			$result = $this->cApi->fetchUriData("https://api.github.com/repos/{$this->username}/{$this->project}/issues/{$id}");
			$data =  json_decode($result);
			$presentation = new \GitHub\Presentation\Basic();
			$presentation->set('issuedata', $data);
			return $presentation->show();
	}
}
