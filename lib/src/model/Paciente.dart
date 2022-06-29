class Paciente {
  String nombreMascota;
  String nombreVeterinario;
  String edad;
  String peso;
  String raza;
  String sexo;
  String razon;
  String estado;
  String nombreDueno;
  String contacto;
  String direccion;

  Paciente(
      {required this.nombreMascota,
      required this.nombreVeterinario,
      required this.contacto,
      required this.direccion,
      required this.edad,
      required this.estado,
      required this.nombreDueno,
      required this.peso,
      required this.raza,
      required this.razon,
      required this.sexo});
}
