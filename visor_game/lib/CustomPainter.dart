import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class GameViewer extends StatefulWidget {
  @override
  _GameViewerState createState() => _GameViewerState();
}

class _GameViewerState extends State<GameViewer> {
  // Conexión al servidor del instituto
  final channel = WebSocketChannel.connect(
    Uri.parse('ws://ieticloudpro.ieti.cat:3000'),
  );

  List players = [];

  @override
  void initState() {
    super.initState();
    // Escuchar los mensajes del servidor Node.js
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['type'] == 'STATE') {
        setState(() {
          players = data['players']; // Actualizamos las posiciones
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Espectador - OceanPark")),
      body: Center(
        child: Container(
          width: 800,
          height: 480,
          color: Colors.black,
          child: CustomPaint(
            painter: GamePainter(players), // Dibujamos a los jugadores
          ),
        ),
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  final List players;
  GamePainter(this.players);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    for (var player in players) {
      // Dibujamos a cada jugador en su posición X e Y enviada por Node.js
      canvas.drawCircle(
        Offset(player['x'].toDouble(), player['y'].toDouble()), 
        10, 
        paint
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}