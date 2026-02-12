class HomeDay {
  final String day;
  final String date;
  final int? checkId;
  final String? checkIn;
  final String? checkOut;
  final int totalPauseMinutes;
  final String totalPauseHuman;
  final bool hasCheck;
  final String? type;

  HomeDay({
    required this.day,
    required this.date,
    required this.checkId,
    required this.checkIn,
    required this.checkOut,
    required this.totalPauseMinutes,
    required this.totalPauseHuman,
    required this.hasCheck,
    this.type,
  });

  // factory HomeDay.fromJson(Map<String, dynamic> json) {
  //   return HomeDay(
  //     day: json['day'],
  //     date: json['date'],
  //     checkId: json['check_id'],
  //     checkIn: json['check_in'],
  //     checkOut: json['check_out'],
  //     totalPauseMinutes: json['total_pause_minutes'],
  //     totalPauseHuman: json['total_pause_human'],
  //     hasCheck: json['has_check'],
  //     type: json['type'],
  //   );
  // }

  factory HomeDay.fromJson(Map<String, dynamic> json) {
  return HomeDay(
    day: json['day']?.toString() ?? '',
    date: json['date']?.toString() ?? '',
    // check_id puede venir null, int o String (por ngrok/DB)
    checkId: json['check_id'] is int 
        ? json['check_id'] 
        : int.tryParse(json['check_id']?.toString() ?? ''),
    checkIn: json['check_in']?.toString(),
    checkOut: json['check_out']?.toString(),
    // Aquí es donde suele tronar: forzamos a int
    totalPauseMinutes: json['total_pause_minutes'] is int 
        ? json['total_pause_minutes'] 
        : int.tryParse(json['total_pause_minutes']?.toString() ?? '0') ?? 0,
    totalPauseHuman: json['total_pause_human']?.toString() ?? '',
    hasCheck: json['has_check'] is bool 
        ? json['has_check'] 
        : (json['has_check']?.toString().toLowerCase() == 'true'),
    type: json['type']?.toString(),
  );
}
}
