<?php
class ExecutorTest extends PHPUnit_Framework_TestCase
{
    private $executor;
    private $parser;
    private $github;
    public function setUp()
    {
        $this->executor = new \GitHub\Executor();
        $this->parser   = new \GitHub\Parser();
        $this->github   = new \GitHub\GitHub();
    }
    public function testHello()
    {
        $expected = 'Hello. My Name is github-sh' . PHP_EOL
            .'I born to help you with LE-ZE-RA to access the browser.' . PHP_EOL
            .'If its our first meet, in doubt, please ask me for help.' . PHP_EOL
            .'Ops, I almost forgot to introduce myself.' . PHP_EOL
            .'The unoccupied person behind me are:' . PHP_EOL
            .'    Henrique Moody <henriquemoody@gmail.com> (creator)' . PHP_EOL
            .'    Ivo nascimento <iannsp@gmail.com> (the helper).' . PHP_EOL
            .'Having Fun!!' . PHP_EOL . PHP_EOL;
      
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("hello")));
      $this->assertEquals($expected, $result);

    }
}
