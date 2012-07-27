<?php
namespace GitHub\Presentation\Issue;

use \GitHub\Presentation\Basic;

class One extends Basic{


	public function show()
	{
		$data 	= $this->data['issue'];
		$title	= $data->title;
		$number = $data->number;
		$return = "{$number} -{$title}".PHP_EOL;	
		


		return $return;
	}
}
