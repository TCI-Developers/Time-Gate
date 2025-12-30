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

  factory HomeDay.fromJson(Map<String, dynamic> json) {
    return HomeDay(
      day: json['day'],
      date: json['date'],
      checkId: json['check_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      totalPauseMinutes: json['total_pause_minutes'],
      totalPauseHuman: json['total_pause_human'],
      hasCheck: json['has_check'],
      type: json['type'],
    );
  }
}
