class Tour {
  final int id;
  final String tour;
  final int days;
  final int cost;

  Tour(
      {required this.id,
      required this.tour,
      required this.days,
      required this.cost});

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      tour: json['tour'],
      days: json['days'],
      cost: json['cost'],
    );
  }
}
