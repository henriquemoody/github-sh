#!/usr/bin/php
<?php

/* Error reporting */
error_reporting(E_ALL | E_STRICT);

$history_file = $_SERVER['HOME'].'/.github-sh-history';
# read history from previous session
if(is_file($history_file))
	  readline_read_history($history_file);
else
	  fclose(fopen($history_file, 'w'));

require 'bootstrap.php';
$parser = new GitHub\Parser;
$exec   = new GitHub\Executor;
$github = new GitHub\GitHub;

echo $exec->doCmd( $github->isValid($parser->parse("hello")));

// The terminal CMD
do{
    $username = $github->get('username');
    $username = (!is_null($username))?"/".$username:"";
    $project  = $github->get('project');
    $project  = (!is_null($project))?"/".$project:"";


    $buf = readline("github{$username}{$project}> ");
    readline_add_history($buf);
    $cmd = $parser->parse($buf);
    $github->isValid($cmd);
    if ( $cmd->isValid) {
        $cmd = $exec->doCmd($cmd);
        if(is_string($cmd)) {
            echo $cmd."\n";
        }
    } else {
        echo "invalid gitHub Command.\n";
    }

} while($buf != "tchau");
readline_write_history($history_file); 

$exec->doCmd( $github->isValid($parser->parse("goodbye")));
