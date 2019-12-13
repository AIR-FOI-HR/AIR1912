<?php

class ConnectionData{

    public $host = "localhost";
    public $database = "air19_meetup";
    public $databaseUsername = "air19_meetup";
    public $databasePassword = "kaEBDe6W6o3OErl6";
    
    public function getConnectionString(){
        $connectionString = mysqli_connect("$this->host", "$this->database", "$this->databasePassword","$this->databaseUsername");
        return $connectionString;
    }

}

?>