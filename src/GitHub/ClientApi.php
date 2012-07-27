<?php
namespace GitHub;
class ClientApi
{
    public function FetchUriData($url)
    {
        $opts = array(
            'http'=>array(
            'method'=>"GET",
            'header'=>"Accept-language: en\r\n" .
            "Cookie: foo=bar\r\n"
                )
            );
        $context = stream_context_create($opts);
        $fp = fopen($url, 'r', false, $context);
        $return = fgets($fp);
        fclose($fp);
        return $return;
    }
    
}
