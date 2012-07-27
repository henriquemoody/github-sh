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
        $parsed = $this->parser->parse($cmd[0]);        
        $this->AssertEquals($cmd, $expected[0]);
    }
    public function testParseDataProvider()
    {
        return array(
        array("hello",array('hello'))
        ,array("tchau",  array('tchau'))
        );
    }
}
