#!/usr/bin/php
<?php

/* Error reporting */
error_reporting(E_ALL | E_STRICT);

/* Timezone */
require 'bootstrap.php';
$parser = new GitHub\Parser;
$exec   = new GitHub\Executor;
$github = new GitHub\GitHub;

$exec->doCmd( $github->isValid($parser->parse("hello")));

// The terminal CMD
do{

    $buf = readline("github> ");
    readline_add_history($buf);
    $cmd = $parser->parse($buf);
    $github->isValid($cmd);
    if ( $cmd->isValid) {
        $cmd = $exec->doCmd($cmd);
        if(is_string($cmd)) {
            echo $cmd;
        }
    } else {
        echo "invalid gitHub Command.\n";
    }

} while($buf != "tchau");
$exec->doCmd( $github->isValid($parser->parse("goodbye")));
