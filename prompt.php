<?php
$stdin = fopen('php://stdin','r');
$out = fopen('php://stdout', 'w');
require 'src/Executor.php';
$exec   = new GitHub\Executor;
$exec->doCmd("help");
// the terminal CMD
do{
		$buf = readline("github> ");
		readline_add_history($buf);
		$cmd = $exec->doCmd($parser->parse($buf));
		var_dump($buf);		
} while($buf !="exit");
