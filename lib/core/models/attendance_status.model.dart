class AttendanceStats {
  final double? retardosTomados;
  final String? tiempoRetardo;
  final String? totalTrabajado;
  final String? tiempoReloj;
  final double? diasTrabajados;
  final double? permisosTomados;
  final double? vacacionesTomadas;
  final double? asistenciasMensuales;
  final double? totalAsistencias;
  final dynamic horasPermisos;
  final dynamic horasExtra;
  final List<String> fechaRetardo;
  final List<String> fechaVacaciones;
  final List<String> fechaPermisos;
  final List<String> fechaAusencias;
  final double? totalAusencias;
  final double? retardosPermitidos;
  final double? permisosPermitidos;
  final double? totalVacaciones;

  AttendanceStats({
    this.retardosTomados,
    this.tiempoRetardo,
    this.totalTrabajado,
    this.tiempoReloj,
    this.diasTrabajados,
    this.permisosTomados,
    this.vacacionesTomadas,
    this.asistenciasMensuales,
    this.totalAsistencias,
    this.horasPermisos,
    this.horasExtra,
    required this.fechaRetardo,
    required this.fechaVacaciones,
    required this.fechaPermisos,
    required this.fechaAusencias,
    this.totalAusencias,
    this.retardosPermitidos,
    this.permisosPermitidos,
    this.totalVacaciones,
  });

  factory AttendanceStats.fromJson(Map<String, dynamic> json) {
    return AttendanceStats(
      retardosTomados: json['retardos_tomados'],
      tiempoRetardo: json['tiempo_retardo'],
      totalTrabajado: json['total_trabajado'],
      tiempoReloj: json['tiempo_reloj'],
      diasTrabajados: json['dias_trabajados'],
      permisosTomados: json['permisos_tomados'],
      vacacionesTomadas: json['vacaciones_tomadas'],
      asistenciasMensuales: json['asistencias_mensuales'],
      totalAsistencias: json['total_asistencias'],
      horasPermisos: json['horas_permisos'],
      horasExtra: json['horas_extra'],
      fechaRetardo: List<String>.from(json['fecha_retardo'] ?? []),
      fechaVacaciones: List<String>.from(json['fecha_vacaciones'] ?? []),
      fechaPermisos: List<String>.from(json['fecha_permisos'] ?? []),
      fechaAusencias: List<String>.from(json['fecha_ausencias'] ?? []),
      totalAusencias: json['total_ausencias'],
      retardosPermitidos: json['retardos_permitidos'],
      permisosPermitidos: json['permisos_permitidos'],
      totalVacaciones: json['total_vacaciones'],
    );
  }
}