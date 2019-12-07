<?php

class ConnectionData{

    public $host = "localhost";
    public $database = "id11519910_projekt";
    public $databaseUsername = "airprojekt2019";
    public $databasePassword = "id11519910_air1912";
    
    public function getConnectionString(){
        $connectionString = mysqli_connect("$this->host", "$this->database", "$this->databaseUsername", "$this->databasePassword");
        return $connectionString;
    }

}

?>