class Stamp {
  // final int id;
  final String date;
  final int cups;

  Stamp({
    // this.id,
    required this.date,
    required this.cups
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'date': date,
      'cups': cups
    };
  }

  factory Stamp.fromMap(Map<String, dynamic> map) {
    return Stamp(
        // id: map['id']?.toInt() ?? 0,
        date: map['date'] ?? '',
        cups: map['cups']?.toInt() ?? 0
    );
  }
}