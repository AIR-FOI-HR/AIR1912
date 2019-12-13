<?php

class JsonResponseBuilder{
    
    static function success_response($json)
    {   
        return JsonResponseBuilder::json_response($json, 200);
    }
    
    
    static function error_response($title, $message, $code)
    {   
        $errorDictionary =  array(
            'title' => $title,
            'message' => $message,
        );
        return JsonResponseBuilder::json_response($errorDictionary, $code);
    }
    
    private function json_response($messageDictionary, $code)
    {
        header_remove(); // clear all previous headers
        
        // set the actual code
        http_response_code($code);
        // set the header to make sure cache is forced
        header("Cache-Control: no-cache");
        // treat this as json
        header('Content-Type: application/json');
        $status = array(
            200 => '200 OK',
            400 => '400 Bad Request',
            422 => 'Unprocessable Entity',
            500 => '500 Internal Server Error'
            );
        // ok, validation error, or failure
        header('Status: '.$status[$code]);
        // return the encoded json
        return json_encode($messageDictionary);
    }

}
?>