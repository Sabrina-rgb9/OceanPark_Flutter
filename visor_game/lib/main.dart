import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// Asegúrate de que estos nombres coincidan con los archivos que creaste arriba
import 'player_model.dart';
import 'game_painter.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FlutterGameViewer(),
  ));
}

class FlutterGameViewer extends StatefulWidget {
  const FlutterGameViewer({super.key});

  @override
  State<FlutterGameViewer> createState() => _FlutterGameViewerState();
}

class _FlutterGameViewerState extends State<FlutterGameViewer> {
  // Cambia localhost por la URL del instituto si vas a probar en red
  late WebSocketChannel channel;
  List<PlayerData> players = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    channel = WebSocketChannel.connect(
      Uri.parse('ws://ieticloudpro.ieti.cat:3000'),
    );

    channel.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['type'] == 'STATE') {
        final List<dynamic> playersList = data['players'];
        setState(() {
          players = playersList.map((p) => PlayerData.fromJson(p)).toList();
        });
      }
    }, onError: (error) {
      print("Error de conexión: $error");
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
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(title: const Text("Visor OceanPark")),
      body: Center(
        child: AspectRatio(
          aspectRatio: 800 / 480,
          child: Container(
            color: Colors.black,
            child: CustomPaint(
              painter: GamePainter(players),
            ),
          ),
        ),
      ),
    );
  }
}