#!/usr/bin/php
<?php

/* Error reporting */
error_reporting(E_ALL | E_STRICT);

/* Timezone */
date_default_timezone_set('UTC');

/* Include path */
set_include_path(implode(PATH_SEPARATOR, array(
    __DIR__ . '/src',
    get_include_path(),
)));

/* PEAR autoloader */
spl_autoload_register(
    function($className) {
        $filename = strtr($className, '\\', DIRECTORY_SEPARATOR) . '.php';
        foreach (explode(PATH_SEPARATOR, get_include_path()) as $path) {
            $path .= DIRECTORY_SEPARATOR . $filename;
            if (is_file($path)) {
                require_once $path;
                return true;
            }
        }
        return false;
    }
);

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
    } else {
        echo "invalid gitHub Command.\n";
    }

} while(true);
$exec->doCmd( $github->isValid($parser->parse("goodbye")));
