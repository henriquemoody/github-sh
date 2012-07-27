<?php
namespace GitHub;

class GitHub
{
    private $user;
    private $pass;
    private $project;
    public function hello()
    {
        return 'Hello. My Name is github-sh' . PHP_EOL
            .'I born to help you with LE-ZE-RA to access the browser.' . PHP_EOL
            .'If its our first meet, in doubt, please ask me for help.' . PHP_EOL
            .'Ops, I almost forgot to introduce myself.' . PHP_EOL
            .'The unoccupied person behind me are:' . PHP_EOL
            .'    Henrique Moody <henriquemoody@gmail.com> (creator)' . PHP_EOL
            .'    Ivo nascimento <iannsp@gmail.com> (the helper).' . PHP_EOL
            .'Having Fun!!' . PHP_EOL . PHP_EOL;

    }
    public function goodbye()
    {
        require __DIR__ . '/randomthought.php';
        $rid = array_rand($thought,1);
        return "Good By.\nand never forgot:\t'{$thought[$rid]}'.\n\n";
    }
    public function isValid(\StdClass $cmd)
    {
        $whatcan = array(
        'hello'=> array('class'=>'GitHub\GitHub', 'method'=>'hello')
        ,'goodbye'=> array('class'=>'GitHub\GitHub', 'method'=>'goodbye')
        ,'tchau'=> array('class'=>'GitHub\GitHub', 'method'=>'goodbye')
        ,'exit'=> array('class'=>'GitHub\GitHub', 'method'=>'goodbye')
        );
        $cmd->isValid = array_key_exists($cmd->command, $whatcan);
        if ($cmd->isValid) {
            $cmd->execution = new \StdClass;
            $cmd->execution->class = $whatcan[$cmd->command]['class'];
            $cmd->execution->method= $whatcan[$cmd->command]['method'];
        }

        return $cmd;
    }

}
