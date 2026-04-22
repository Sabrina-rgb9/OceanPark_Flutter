class PlayerData {
  final String id;
  final String name;
  final double x;
  final double y;

  PlayerData({required this.id, required this.name, required this.x, required this.y});

  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      id: json['id'].toString(),
      name: json['name'] ?? 'Sin nombre',
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );
  }
}