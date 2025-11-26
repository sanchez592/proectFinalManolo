<?php
require_once __DIR__ . '/../config/database.php';

class Usuario {
    private $conn;
    private $table = "usuarios";

    public $id;
    public $nombre;
    public $email;
    public $password;
    public $tipo;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    public function registrar() {
        $query = "INSERT INTO " . $this->table . " (nombre, email, password, tipo) 
                  VALUES (:nombre, :email, :password, 'usuario')";
        $stmt = $this->conn->prepare($query);
        
        $stmt->bindParam(":nombre", $this->nombre);
        $stmt->bindParam(":email", $this->email);
        $hashed_password = password_hash($this->password, PASSWORD_DEFAULT);
        $stmt->bindParam(":password", $hashed_password);
        
        if($stmt->execute()) {
            return true;
        }
        return false;
    }

    public function login($email, $password) {
        $query = "SELECT * FROM " . $this->table . " WHERE email = :email LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        $stmt->execute();
        
        $usuario = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if($usuario && password_verify($password, $usuario['password'])) {
            $this->id = $usuario['id'];
            $this->nombre = $usuario['nombre'];
            $this->email = $usuario['email'];
            $this->tipo = $usuario['tipo'];
            return true;
        }
        return false;
    }

    public function existeEmail($email) {
        $query = "SELECT id FROM " . $this->table . " WHERE email = :email";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(":email", $email);
        $stmt->execute();
        return $stmt->rowCount() > 0;
    }
}
?>



