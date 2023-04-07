class Attendance {
  final int id;
  final int userId;
  final DateTime checkInTime;
  final DateTime? checkOutTime;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.id,
    required this.userId,
    required this.checkInTime,
    this.checkOutTime,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.nullAttendance() {
    return Attendance(
      id: 0,
      userId: 0,
      checkInTime: DateTime.fromMillisecondsSinceEpoch(0),
      checkOutTime: null,
      date: DateTime.fromMillisecondsSinceEpoch(0),
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
    );
  }

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['attendance_id'],
      userId: json['user_id'],
      checkInTime: DateTime.parse(json['check_in_time']),
      checkOutTime: json['check_out_time'] != null
          ? DateTime.parse(json['check_out_time'])
          : null,
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
