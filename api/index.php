<?php
require_once(__DIR__.'/../config/config.php');

$metodo = strtolower($_SERVER['REQUEST_METHOD']);
$accion = explode('/', strtolower($_GET['accion']));
$funcionNombre = $metodo . ucfirst($accion[0]);
$parametros = array_slice($accion, 1);
if (count($parametros) >0 && $metodo == 'get') {
    $funcionNombre = $funcionNombre.'ConParametros';
}
if (function_exists($funcionNombre)) {
    call_user_func_array ($funcionNombre, $parametros);
} else {
    outputError(400);
}

function outputJson($data, $codigo = 200)
{
    header('', true, $codigo);
    header('Content-type: application/json');
    print json_encode($data);
    die;
}

function outputError($codigo = 500)
{
    switch ($codigo) {
        case 400:
            header($_SERVER["SERVER_PROTOCOL"] . " 400 Bad request", true, 400);
            die;
        case 404:
            header($_SERVER["SERVER_PROTOCOL"] . " 404 Not Found", true, 404);
            die;
        default:
            header($_SERVER["SERVER_PROTOCOL"] . " 500 Internal Server Error", true, 500);
            die;
            break;
    }
}

function conectarBD()
{
    $link = mysqli_connect(DBHOST, DBUSER, DBPASS, DBBASE);
    if ($link === false) {
        print "Falló la conexión: " . mysqli_connect_error();
        outputError(500);
    }
    return $link;
}

function postRestablecer () {
	$db = conectarBD();
	$sql = RESTABLECERSQL;
	$result = mysqli_multi_query($db, $sql);
	if ($result===false) {
		print mysqli_error($db);
		outputError(500);
	}
	mysqli_close($db);
	outputJson([], 201);
}

function getTurnosConParametros ($id) {
	$link = conectarBD();
	settype($id, 'integer');
    
		$sql = "SELECT t.mes, t.dia, t.hora
						  FROM turnos t
					   WHERE t.vacunaId = $id
						   AND t.tomado = 0";

	$resultado = mysqli_query($link, $sql);

	if ($resultado === false) {
		print mysqli_error($link);
		outputError(500);
	}
	if (mysqli_num_rows($resultado)==0) {
		outputError(404);
	}
	
	$response["turnos"] = [];

	while ($row = mysqli_fetch_assoc($resultado)) {
			$response["turnos"][] = $row;
	}

	mysqli_free_result($resultado);
	mysqli_close($link);
	outputJson($response, 200);
}

function patchTurnos () {
	$link = conectarBD();
	
	$dato = json_decode(file_get_contents('php://input'), true);
	$vacId = mysqli_real_escape_string($link, $dato['vacId']);
	$mes = mysqli_real_escape_string($link, $dato['mes']);
	$dia = mysqli_real_escape_string($link, $dato['dia']);
	$hora = mysqli_real_escape_string($link, $dato['hora']);

	$sql = "UPDATE turnos SET tomado = 1 
					 WHERE vacunaId = '$vacId' 
					   AND mes = '$mes'
						 AND dia = '$dia'
						 AND hora = '$hora'";


	$resultado = mysqli_query($link, $sql);
	if ($resultado === false) {
		print mysqli_error($link);
		outputError(500);
	}

	mysqli_close($link);
	outputJson([], 200);
}

function postPacientes () {
	$link = conectarBD();
	$dato = json_decode(file_get_contents('php://input'), true);
	$nombres = mysqli_real_escape_string($link, $dato['nombres']);
	$apellidos = mysqli_real_escape_string($link, $dato['apellidos']);
	$dni = mysqli_real_escape_string($link, $dato['dni']);
	$tel = mysqli_real_escape_string($link, $dato['tel']);
	$email = mysqli_real_escape_string($link, $dato['email']);
	$vacunaId = mysqli_real_escape_string($link, $dato['vacunaId']);
	$mes = mysqli_real_escape_string($link, $dato['mes']);
	$dia = mysqli_real_escape_string($link, $dato['dia']);
	$hora = mysqli_real_escape_string($link, $dato['hora']);
	
	$sql = "INSERT INTO pacientes (nombres, apellidos, dni, tel, email, vacunaId, mes, dia, hora) 
          VALUES ('$nombres', '$apellidos', '$dni','$tel','$email','$vacunaId','$mes','$dia','$hora')";
	
	$resultado = mysqli_query($link, $sql);
	if ($resultado === false) {
		print mysqli_error($link);
		outputError(500);
	}

	mysqli_close($link);
	outputJson($resultado, 200);
}
