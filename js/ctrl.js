/* 
	Main controller
*/
angular.module('parcialApp', []).controller('parcialCtrl', function ($scope, $http, $log, $timeout) {

	$scope.step1 = false;
	$scope.step2 = false;
	$scope.step3 = false;

	$scope.mensajeFinal = false;

	$scope.userdata = {};

	$scope.selectedVac = null;

	$scope.selectedDay;
	$scope.selectedHour;
	$scope.selectedMonth;
	$scope.vacName = "";

	$scope.merged = [];
	$scope.dias = [];
	$scope.meses = [];
	$scope.horarios = [];

	$scope.indexMes = null;
	$scope.indexDia = null;
	$scope.indexHora = null;


	/*			 */
	/* START */
	/*			 */
	
	$scope.activarSesion = function () {
		if (!$scope.step1) {
			$scope.step1 = true;
		}
		$scope.mensajeFinal = false;
	}


	/* 									*/
	/* FORMULARIO DATOS */
	/* 									*/

	$scope.resetDatos = function () {
		$scope.userdata = {};
	}

	$scope.guardarDatos = function () {
		console.log($scope.userdata)
		$scope.step1 = false;
		$scope.step2 = true;

	}

	/*				*/
	/* TURNOS */
	/*				*/

	$scope.getTurnos = function (id) {

		$scope.dias = [];
		$scope.horarios = [];
		$scope.selectedHour = null;
		$scope.selectedVac = id;
		$scope.indexMes = null;

		$http.get('api/turnos/' + id)
			.then(function (response) {
				console.log(response)
				$scope.step3 = true;
				$scope.vacData = response.data.turnos;

				$scope.vacData.forEach(fecha => {

					if (!$scope.meses.includes(fecha.mes)) {
						$scope.meses.push(fecha.mes)
					}

				});
			})
			.catch(function () {
				$scope.vacData = [{ "mes": 7, "dia": 1, "hora": 10 },
				{ "mes": 7, "dia": 1, "hora": 11 },
				{ "mes": 7, "dia": 2, "hora": 12 },
				{ "mes": 8, "dia": 1, "hora": 10 },
				{ "mes": 9, "dia": 1, "hora": 10 },
				];
				$scope.vacData.forEach(fecha => {

					if (!$scope.meses.includes(fecha.mes)) {
						$scope.meses.push(fecha.mes)
					}

				});
			})
	}

	$scope.setMonth = function (mes, idx) {

		$scope.selectedMonth = mes;
		$scope.dias = [];
		$scope.horarios = [];
		$scope.selectedHour = null;
		$scope.indexMes = idx;
		$scope.indexDia = null;

		$scope.vacData.forEach(fecha => {

			if (fecha.mes == $scope.selectedMonth && !$scope.dias.includes(fecha.dia)) {
				$scope.dias.push(fecha.dia)
			}

		});

	}

	$scope.setDay = function (dia, idx) {

		$scope.selectedDay = dia;
		$scope.horarios = [];
		$scope.selectedHour = null;
		$scope.indexDia = idx;
		$scope.indexHora = null;
		
		$scope.vacData.forEach(fecha => {

			if (fecha.mes == $scope.selectedMonth &&
				fecha.dia == dia &&
				!$scope.horarios.includes(fecha.hora)) {
				$scope.horarios.push(fecha.hora)
			}

		});

	}




	$scope.setTime = function (hora, idx) {
		$scope.selectedHour = hora;
		$scope.indexHora = idx;
	}


	$scope.confirmarTurno = function () {

		switch ($scope.selectedVac) {
			case 1:
				$scope.vacName = "ChinoFarm";
				break;
			case 2:
				$scope.vacName = "Pfazziner";
				break;
			case 3:
				$scope.vacName = "Astral Azteca";
				break;
			case 4:
				$scope.vacName = "Robert & Robert";
				break;
		}
		let subject = "Confirmación de turno para la vacuna " + $scope.vacName;
		let body = encodeURIComponent(document.getElementById('emailBody').value)

		var turnoTomado = {
			vacId: $scope.selectedVac,
			mes: $scope.selectedMonth,
			dia: $scope.selectedDay,
			hora: $scope.selectedHour
		}

		// Guardo turno primero
		$http.patch('api/turnos/', turnoTomado)
			.then(function (response) {

				let fullData = {
					nombres: $scope.userdata.nombres,
					apellidos: $scope.userdata.apellidos,
					dni: $scope.userdata.dni,
					tel: $scope.userdata.tel,
					email: $scope.userdata.email,
					vacunaId: $scope.selectedVac,
					mes: $scope.selectedMonth,
					dia: $scope.selectedDay,
					hora: $scope.selectedHour
				}

				// Guardo paciente con su turno
				$http.post('api/pacientes/', fullData)
					.then(function (response) {

						$timeout(function () {
							alert("Turno guardado con exito");
						}, 0);

						window.open('mailto:' + $scope.userdata.email + '?subject=' + subject + '&body=' + body);
						$scope.restartAll();
						window.scrollTo(0, 0);
					})
					.catch(function () {
						$timeout(function () {
							alert('Error guardando paciente');
						}, 0);
					});

			})
			.catch(function () {
				$timeout(function () {
					alert('Error guardando turno');
				}, 0);
			});

	}

	$scope.restartAll = function () {
		$scope.step1 = false;
		$scope.step2 = false;
		$scope.step3 = false;

		$scope.userdata = {};

		$scope.selectedVac = null;

		$scope.selectedDay;
		$scope.selectedHour;
		$scope.selectedMonth;
		$scope.vacName = "";

		$scope.merged = [];
		$scope.dias = [];
		$scope.meses = [];
		$scope.horarios = [];

		$scope.mensajeFinal = true;
	}


	/* 									*/
	/* FUNCIONES HELPER */
	/* 									*/

	$scope.nombreMes = function (num) {

		let meses = ["0", "enero",
			"febrero", "marzo",
			"abril", "mayo",
			"junio", "julio",
			"agosto", "septiembre",
			"octubre", "noviembre",
			"diciembre"]

		return meses[num];
	}

	$scope.nombreVac = function (num) {

		let vacs = ["0", "ChinoFarm", "Pfazziner", "Astral Azteca", "Robert & Robert"]
		return vacs[num];
	}

	$scope.class = "not-selected";
	$scope.changeClass = function () {
		if ($scope.class === "selected")
			$scope.class = "not-selected";
		else
			$scope.class = "selected";
	};


});



