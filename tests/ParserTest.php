<?php
class ParserTest extends PHPUnit_Framework_TestCase
{
    private $parser;
    public function setUp()
    {
        $this->parser = new \GitHub\Parser();
    }
    /**
     * @dataProvider testParseDataProvider 
     */
    public function testParse($cmd, $expected)
    {
        $cmdexpected = explode(' ', $cmd);
        $parsed = $this->parser->parse($cmd[0]);        
        $this->AssertEquals($cmdexpected[0], $expected[0]);
    }
    public function testParseDataProvider()
    {
        return array(
        array("hello",array('hello'))
        ,array("tchau",  array('tchau'))
        );
    }
}
