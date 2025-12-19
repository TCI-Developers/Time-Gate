class UserProfile {
  final int id;
  final String name;
  final String email;
  final String puesto;
  final String area;
  final String idEmpleado;
  final String antiguedad;
  final String telefono;
  final String direccion;
  final String firmaContrato;
  final String? rescisionContrato;
  final String fechaNacimiento;
  final String nss;
  final String curp;
  final String rfc;
  final String profilePhotoUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.puesto,
    required this.area,
    required this.idEmpleado,
    required this.antiguedad,
    required this.telefono,
    required this.direccion,
    required this.firmaContrato,
    this.rescisionContrato,
    required this.fechaNacimiento,
    required this.nss,
    required this.curp,
    required this.rfc,
    required this.profilePhotoUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      puesto: json['puesto'],
      area: json['area'],
      idEmpleado: json['id_empleado'],
      antiguedad: json['antiguedad'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      firmaContrato: json['firma_contrato'],
      rescisionContrato: json['rescision_contrato'],
      fechaNacimiento: json['fecha_nacimiento'],
      nss: json['nss'],
      curp: json['curp'],
      rfc: json['rfc'],
      profilePhotoUrl: json['profile_photo_path'],
    );
  }
}
