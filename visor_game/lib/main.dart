import 'package:flutter/material.dart';
import 'package:flame/game.dart';
// ¡Nueva línea! Importamos los componentes de Flame para poder usar imágenes
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
    
    // 1. Cargamos la imagen desde la carpeta assets/images/
    // (Asegúrate de que el nombre coincida con tu archivo real)
    final spriteFondo = await loadSprite('backgrounds/background.png');

    // 2. Creamos el "Componente" que mostrará esa imagen
    final fondo = SpriteComponent(
      sprite: spriteFondo,
      size: size, // Le decimos que el tamaño sea igual a "size" (el tamaño total de la pantalla)
    );

    // 3. Lo añadimos al lienzo
    add(fondo);

    print("¡Fondo cargado correctamente!");
  }
}