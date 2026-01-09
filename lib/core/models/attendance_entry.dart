class AttendanceEntry {
  final String? day;
  final String? date;
  final int? checkId;
  final String? checkIn;
  final String? checkOut;
  final List<String> pause;
  final dynamic totalTrabajado;
  final dynamic totalTrabajadoReloj;
  final String? type;
  final int? ausencia;
  final int? retardo;

  AttendanceEntry({
    this.day,
    this.date,
    this.checkId,
    this.checkIn,
    this.checkOut,
    required this.pause,
    this.totalTrabajado,
    this.totalTrabajadoReloj,
    this.type,
    this.ausencia,
    this.retardo,
  });

  factory AttendanceEntry.fromJson(Map<String, dynamic> json) {
    return AttendanceEntry(
      day: json['day'],
      date: json['date'],
      checkId: json['check_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      pause: List<String>.from(json['pause'] ?? []),
      totalTrabajado: json['total_trabajado'],
      totalTrabajadoReloj: json['total_trabajado_reloj'],
      type: json['type'],
      ausencia: json['ausencia'],
      retardo: json['retardo'],
    );
  }
}