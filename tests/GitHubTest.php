<?php
class GitHubTest extends PHPUnit_Framework_TestCase
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
    public function testSetParamUserName()
    {
      $expected =  'batman';
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("set username batman")));
      $this->assertEquals($expected, $result);
    }
    public function testGetParamUserName()
    {
      $expected =  'batman';
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("set username batman")));
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("get username")));
      $this->assertEquals($expected, $result);
    }
    public function testSetParamProject()
    {
      $expected =  'DestroyGottanCity';
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("set project {$expected}")));
      $this->assertEquals($expected, $result);
    }
    public function testGetParamProject()
    {
      $expected =  'DestroyGottanCity';
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("set project {$expected}")));
 
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("get project")));
      $this->assertEquals($expected, $result);
    }

    public function testSetInvalidParam()
    {
      $expected =  'DestroyGottanCity';
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("set ThePlan {$expected}")));
      $this->assertEquals('property ThePlan not valid', $result);
    }
     public function testGetInvalidParam()
    {
      $result = $this->executor->doCmd( $this->github->isValid($this->parser->parse("get ThePlan")));
      $this->assertEquals('property github.ThePlan don\'t exist.', $result);
    }
 

} 
