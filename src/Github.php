<?php
namespace GitHub;
class GitHub{
	private $user;
	private $pass;
	private $project;
	public function hello()
	{
		echo "Hello. My Name is github-sh\n I born to help you with LE-ZE-RA to access the browser.\nIf its our first meet, in doubt, please ask me for help. Ops, I almost forgot to introduce myself.\n the unoccupied person behind me are:\n\thenrique Moody <henriquemoody@gmail.com> (creator) \n\tIvo nascimento <iannsp@gmail.com> (the helper).\nHaving Fun!!\n\n";

	}
	public function goodbye()
	{
		require 'src/randomthought.php';
		$rid = array_rand($thought,1);
		echo "Good By.\nand never forgot:\t'{$thought[$rid]}'.\n\n ";
		exit(0);
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
			if( $cmd->isValid) 
			{
				$cmd->execution = new \StdClass;
				$cmd->execution->class = $whatcan[$cmd->command]['class'];
				$cmd->execution->method= $whatcan[$cmd->command]['method'];
			}
			return $cmd;
	}

}
