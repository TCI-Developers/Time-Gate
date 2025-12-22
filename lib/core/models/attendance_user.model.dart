class AttendanceUser {
  final String name;
  final String puesto;
  final String? profilePhotoPath;

  AttendanceUser({
    required this.name,
    required this.puesto,
    this.profilePhotoPath,
  });

  factory AttendanceUser.fromJson(Map<String, dynamic> json) {
    return AttendanceUser(
      name: json['name'],
      puesto: json['puesto'],
      profilePhotoPath: json['profile_photo_path'],
    );
  }
}
