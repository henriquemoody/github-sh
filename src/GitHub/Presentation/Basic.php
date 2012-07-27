<?php

namespace GitHub\Presentation;

class Basic 
{
		protected $data = array();
		public function set($dataname, $data)
		{
			$this->data[$dataname] = $data;	
		}

		public function get($dataname)
		{
			return (array_key_exists($dataname, $this->data))?$this->data[$dataname]:"";
		}

		public function show()
		{
			ob_start();
			var_dump($this->data);
			$result = ob_get_contents();
			ob_end_clean();
			return $result;
		}

}
