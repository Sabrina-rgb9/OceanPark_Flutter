import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'game_painter.dart'; // Tu archivo de dibujo
import 'player_model.dart';  // Tu modelo de datos

void main() => runApp(const MaterialApp(home: GameViewer()));

class GameViewer extends StatefulWidget {
  const GameViewer({super.key});
  @override
  State<GameViewer> createState() => _GameViewerState();
}

class _GameViewerState extends State<GameViewer> {
  // Conexión a la URL de Proxmox
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://pico3.ieti.site'), 
  );

  List<PlayerData> players = [];

  @override
  void initState() {
    super.initState();
    
    // 1. Enviamos el mensaje de JOIN nada más conectar
    // Esto es vital porque tu app.js ignora a quien no haga JOIN
    channel.sink.add(jsonEncode({
      "type": "JOIN",
      "name": "Visor_Web"
    }));

    // 2. Escuchamos el flujo de datos (STATE)
  // Dentro del listen del channel
  channel.stream.listen((message) {
    final data = jsonDecode(message);
    if (data['type'] == 'STATE') {
      setState(() {
        final List<dynamic> serverPlayers = data['players'];
        // Filtramos para NO dibujar al visor
        players = serverPlayers
            .map((p) => PlayerData.fromJson(p))
            .where((p) => p.name != "Visor_Web") 
            .toList();
      });
    }
  });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: 800 / 480, // Proporción de tu mapa de LibGDX
          child: CustomPaint(
            painter: GamePainter(players),
          ),
        ),
      ),
    );
  }
}