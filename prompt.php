<?php
$stdin = fopen('php://stdin','r');
$out = fopen('php://stdout', 'w');
require 'src/Executor.php';
require 'src/Parser.php';
require 'src/Github.php';
$parser = new github\Parser;
$exec   = new GitHub\Executor;
$github = new GitHub\GitHub;
$exec->doCmd( $github->isValid($parser->parse("hello")));
// the terminal CMD
do{
		$buf = readline("github> ");
		readline_add_history($buf);
		$cmd = $parser->parse($buf);
		$github->isValid($cmd);
		if ( $cmd->isValid) {
			$cmd = $exec->doCmd($cmd);
		} else {
			echo "invalid gitHub Command.\n";
		}

} while(true);
$exec->doCmd( $github->isValid($parser->parse("goodbye")));
