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
        $parsed = $this->parser->parse($cmd);        
        $this->AssertEquals($expected[0], $parsed->command);
        $this->AssertEquals($expected[1], $parsed->parameters);
    }
    public function testParseDataProvider()
    {
        return array(
        array("hello",array('hello', array()))
        ,array("tchau",  array('tchau', array()))
        ,array("tchau lilika",  array('tchau', array('lilika')))
        );
    }
}
