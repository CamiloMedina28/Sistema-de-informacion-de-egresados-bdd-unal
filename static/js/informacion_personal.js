function eliminar_egresado(id) {
  fetch(`/eliminar_egresado?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function eliminar_familiar(id) {
  fetch(`/eliminar_familiar?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function eliminar_residencia(id) {
  fetch(`/eliminar_residencia?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function eliminar_distincion(id) {
  fetch(`/eliminar_distincion?id_egresado=${id}`)
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function add_info_form() {
  document.getElementById("tabla_info").style.display = "none";
  document.getElementById("formulario_añadir").style.display = "flex";
}

function add_informacion_contacto() {
  var documento = document.getElementById("documento").value;
  var telefono_principal = document.getElementById("telefono_principal").value;
  var correo = document.getElementById("correo").value;
  var telefono_adicional = document.getElementById("telefono_adicional").value;
  var correo_adicional = document.getElementById("correo_adicional").value;
  fetch(
    `/agregar-info-contacto?documento=${documento}&telefono-principal=${telefono_principal}&correo=${correo}&telefono-adicional=${telefono_adicional}&correo-adicional=${correo_adicional}`
  )
    .then((response) => response.text())
    .then((data) => {
      // window.location.href = "http://127.0.0.1:5010/bibliotecario/libros";
      alert(data);
    });
}

function edit_contacto_form(
  documento,
  telefono_principal,
  correo,
  telefono_adicional,
  correo_adicional
) {
  add_info_form();
  document.getElementById("documento").value = documento;
  document.getElementById("telefono_principal").value = telefono_principal;
  document.getElementById("correo").value = correo;
  document.getElementById("telefono_adicional").value = telefono_adicional;
  document.getElementById("correo_adicional").value = correo_adicional;
}

function add_informacion_residencia() {
  var documento = document.getElementById("documento").value;
  var pais = document.getElementById("pais").value;
  var departamento = document.getElementById("departamento").value;
  var ciudad = document.getElementById("ciudad").value;
  var direccion = document.getElementById("direccion").value;
  fetch(
    `/agregar-info-residencia?documento=${documento}&pais=${pais}&departamento=${departamento}&ciudad=${ciudad}&direccion=${direccion}`
  )
    .then((response) => response.text())
    .then((data) => {
      alert(data);
    });
}

function edit_residencia_form(
  documento,
  pais,
  departamento,
  ciudad,
  direccion
) {
  add_info_form();
  document.getElementById("documento").value = documento;
  document.getElementById("pais").value = pais;
  document.getElementById("departamento").value = departamento;
  document.getElementById("ciudad").value = ciudad;
  document.getElementById("direccion").value = direccion;
}
