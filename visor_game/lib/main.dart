import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GameWidget(game: VisorOceanPark()),
  );
}

class VisorOceanPark extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    // 1. Cargamos el fondo (suponiendo que le quitaste el "size: size" para que mantenga su tamaño real)
    final spriteFondo = await loadSprite('backgrounds/background.png');
    final fondo = SpriteComponent(
      sprite: spriteFondo,
    );
    add(fondo);

    // 2. Cargamos la plataforma
    final spritePlataforma = await loadSprite('platforms/platform.png');
    
    final plataforma = SpriteComponent(
      sprite: spritePlataforma,
      
      // EL CAMBIO ESTÁ AQUÍ: 
      // Le decimos que de ancho mida lo mismo que la imagen del fondo (fondo.size.x)
      size: Vector2(fondo.size.x, spritePlataforma.srcSize.y),
      
      anchor: Anchor.bottomLeft,
      
      // Y LA POSICIÓN TAMBIÉN:
      // La colocamos en la parte más baja del FONDO, no de la pantalla
      position: Vector2(0, fondo.size.y),
    );

    add(plataforma);

    print("¡Fondo y Plataforma sincronizados!");
  }
}