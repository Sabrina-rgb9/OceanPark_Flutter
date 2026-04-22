import 'package:flutter/material.dart';
import 'player_model.dart';

class GamePainter extends CustomPainter {
  final List<PlayerData> players;
  GamePainter(this.players);

  @override
  void paint(Canvas canvas, Size size) {
    final paintPlayer = Paint()..color = Colors.blueAccent;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    for (var player in players) {
      canvas.drawCircle(Offset(player.x, player.y), 15, paintPlayer);
      textPainter.text = TextSpan(
        text: player.name,
        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(player.x - (textPainter.width / 2), player.y - 35));
    }
  }

  @override
  bool shouldRepaint(covariant GamePainter oldDelegate) => true;
}