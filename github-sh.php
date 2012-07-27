#!/usr/bin/php
<?php

/* Error reporting */
error_reporting(E_ALL | E_STRICT);

/* Timezone */
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
$exec->doCmd( $github->isValid($parser->parse("goodbye")));
