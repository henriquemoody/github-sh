<?php
namespace GitHub;

class Executor{

	public function doCmd($cmd)
	{
			$instance = new $cmd->execution->class;
			$reflectionMethod = new \ReflectionMethod($instance, $cmd->execution->method);
			$result = $reflectionMethod->invokeArgs($instance, $cmd->parameters);
			return $result;
	}
}
