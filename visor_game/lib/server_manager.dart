class PlayerData {
  final String id;
  final String name;
  final double x;
  final double y;

  PlayerData({required this.id, required this.name, required this.x, required this.y});

  // Convierte el JSON del servidor a un objeto de Dart
  factory PlayerData.fromJson(Map<String, dynamic> json) {
    return PlayerData(
      id: json['id'],
      name: json['name'],
      x: json['x'].toDouble(),
      y: json['y'].toDouble(),
    );
  }
}