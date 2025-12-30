class HomeUser {
  final String name;
  final String puesto;
  final String? profilePhotoPath;
  final String horaEntrada;
  final String horaSalida;
  final String horaInicioComida;
  final String horaFinComida;
  
  HomeUser({
    required this.name,
    required this.puesto,
    this.profilePhotoPath,
    required this.horaEntrada,
    required this.horaSalida,
    required this.horaInicioComida,
    required this.horaFinComida,
  });

  factory HomeUser.fromJson(Map<String, dynamic> json) {
    return HomeUser(
      name: json['name'],
      puesto: json['puesto'],
      profilePhotoPath: json['profile_photo_path'],
      horaEntrada: json['hora_entrada'],
      horaSalida: json['hora_salida'],
      horaInicioComida: json['hora_inicio_comida'],
      horaFinComida: json['hora_final_comida'],
    );
  }
}
