<?php
namespace GitHub;

/**
 * Parser
 *
 * @package github
 * @author Ivo Nascimento <iannsp@gmail.com>
 */
class Parser
{
    public function parse($stringcmd)
    {
        $parts = explode (" ", $stringcmd);
        $cmd = new \StdClass;
        $cmd->command = array_shift($parts);
        $cmd->parameters = $parts;

        return $cmd;
    }
}
