<?php
class ClientApiTest extends PHPUnit_Framework_TestCase
{
    private $cApi;
    public function setUp()
    {
        $this->cApi = new \GitHub\ClientApi;
    }
    public function testBasicGet()
    {
        $content = $this->cApi->FetchUriData("http://www.unixtimestamp.com/index.php");
        $this->assertStringStartsWith('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">', $content);
    }
}
 
