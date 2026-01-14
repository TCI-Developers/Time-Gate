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
  final List<String>? fechaRetardo;
  final List<String>? fechaVacaciones;
  final List<String>? fechaPermisos;
  final List<String>? fechaAusencias;
  final double? totalAusencias;
  final double? retardosPermitidos;
  final double? permisosPermitidos;
  final double? totalVacaciones;
  final String? tiempoTomado;
  final double? diasExtra;
  final double? ausenciasPermitidas;
  final List<String>? fechaAsistencia;
  

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
    this.fechaRetardo,
    this.fechaVacaciones, 
    this.fechaPermisos,
    this.fechaAusencias,
    this.totalAusencias,
    this.retardosPermitidos,
    this.permisosPermitidos,
    this.totalVacaciones,
    this.tiempoTomado,
    this.diasExtra,
    this.ausenciasPermitidas,
    this.fechaAsistencia
    
  });

  factory AttendanceStats.fromJson(Map<String, dynamic> json) {
    return AttendanceStats(
      retardosTomados: json['retardos_tomados']?.toDouble(),
      tiempoRetardo: json['tiempo_retardo'],
      totalTrabajado: json['total_trabajado'],
      tiempoReloj: json['tiempo_reloj'],
      diasTrabajados: json['dias_trabajados']?.toDouble(),
      permisosTomados: json['permisos_tomados']?.toDouble(),
      vacacionesTomadas: json['vacaciones_tomadas']?.toDouble(),
      asistenciasMensuales: json['asistencias_mensuales']?.toDouble(),
      totalAsistencias: json['total_asistencias']?.toDouble(),
      horasPermisos: json['horas_permisos'],
      horasExtra: json['horas_extra'],
      fechaVacaciones: [],
      fechaRetardo: json['fecha_retardo'] != null 
          ? List<String>.from(json['fecha_retardo']) 
          : null,
      fechaPermisos: json['fecha_permisos'] != null 
          ? List<String>.from(json['fecha_permisos']) 
          : null,
      fechaAusencias: json['fecha_ausencias'] != null 
          ? List<String>.from(json['fecha_ausencias']) 
          : null,
      totalAusencias: json['total_ausencias']?.toDouble(),
      retardosPermitidos: json['retardos_permitidos']?.toDouble(),
      permisosPermitidos: json['permisos_permitidos']?.toDouble(),
      totalVacaciones: json['total_vacaciones']?.toDouble(),
      diasExtra: json['dias_extra']?.toDouble(),
      ausenciasPermitidas: json['ausencias_permitidas']?.toDouble(),
      fechaAsistencia: json['fecha_asistencias'] != null 
          ? List<String>.from(json['fecha_asistencias']) 
          : null,
      
    );
  }
}
