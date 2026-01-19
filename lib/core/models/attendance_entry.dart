class AttendanceEntry {
  final String? day;
  final String? date;
  final int? checkId;
  final String? checkIn;
  final String? checkOut;
  final List<String>? pause;
  final dynamic totalTrabajado;
  final dynamic totalTrabajadoReloj;
  final String? type;
  final int? ausencia;
  final int? retardo;
  final String? fechaRango;
  final String? status;
  final int? diasSolicitados;
  final int? totalDias;

  AttendanceEntry({
    this.day,
    this.date,
    this.checkId,
    this.checkIn,
    this.checkOut,
    this.pause,
    this.totalTrabajado,
    this.totalTrabajadoReloj,
    this.type,
    this.ausencia,
    this.retardo,
    this.fechaRango,
    this.status,
    this.diasSolicitados,
    this.totalDias,
  });

  factory AttendanceEntry.fromJson(Map<String, dynamic> json) {
    return AttendanceEntry(
      day: json['day'] ?? '',
      date: json['date'] ?? '',
      checkId: json['check_id'],
      checkIn: json['check_in'] ??'',
      checkOut: json['check_out'] ??'',
      pause: List<String>.from(json['pause'] ?? []),
      totalTrabajado: json['total_trabajado'],
      totalTrabajadoReloj: json['total_trabajado_reloj'],
      type: json['type'],
      ausencia: json['ausencia'],
      retardo: json['retardo'],
      fechaRango: json['rango_fecha']??'',
      status: json['status']??'',
      diasSolicitados: json['dias_solicitados'],
      totalDias: json['total_dias'],
    );
  }
}