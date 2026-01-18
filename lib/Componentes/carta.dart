import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// Definimos un tamaño constante para todas las cartas.
final cartaSize = Vector2(60, 90);

class Carta extends PositionComponent {
  final String colorFrente;
  final String reversoPath;
  bool mostrandoFrente = false;

  
  late final Paint paint;

  // Variable para almacenar el Sprite cargado.
  Sprite? reversoSprite;
  Sprite? frentePaint;
  

  Carta({
    // Parámetros opcionales con valores por defecto para compatibilidad
    this.colorFrente = 'default_frente.png',
    this.reversoPath = 'default_reverso.png',
    Vector2? size,
    Vector2? position,
  }) : super(
          position: position ?? Vector2.zero(),
          size: size ?? cartaSize,
          anchor: Anchor.center,
        ) {
    paint = Paint()..color = Colors.grey;
  }

  @override
  Future<void> onLoad() async {
    // Solo intentamos cargar si el path no es el valor por defecto.
    if (reversoPath != 'default_reverso.png') {
      try {
        // Carga la imagen y la guarda en la variable 'reversoSprite'
        reversoSprite = await Sprite.load('cartas/$reversoPath');
      } catch (e) {
        // Si hay un error de carga (path incorrecto), solo imprime y no crashea
        print('ERROR al cargar el asset de la carta: $reversoPath. $e');
      }
    }

    if (colorFrente != 'default_frente.png') {
      try {
        // Carga la imagen y la guarda en la variable 'reversoSprite'
        frentePaint = await Sprite.load('cartas/$colorFrente');
      } catch (e) {
        // Si hay un error de carga (path incorrecto), solo imprime y no crashea
        print('ERROR al cargar el asset de la carta: $colorFrente. $e');
      }
    }

    return super.onLoad();
  }

  // Método simple para cambiar el estado de la carta.
  void voltear() {
    mostrandoFrente = !mostrandoFrente;
  }

  @override
  void render(Canvas canvas) {
    // Si está de frente (true), dibuja el rectángulo de color sólido.
    if (mostrandoFrente) {
      if (frentePaint != null) {
        frentePaint!.render(
          canvas,
          size: size,
          overridePaint: paint,
        );
      }
      else {
        canvas.drawRect(size.toRect(), paint);
      }
    }
    // Si está de reverso (false)
    else {
      if (reversoSprite != null) {
        reversoSprite!.render(
          canvas,
          size: size,
          overridePaint: paint,
        );
      }
      // Si el Sprite es nulo (no se cargó o es la carta por defecto), dibujamos un color.
      else {
        canvas.drawRect(size.toRect(), paint);
      }
    }
  }
}

// ------------------------------------
// ---- 4 tipos de cartas (Subclases) --
// ------------------------------------
// No hay cambios en la sintaxis aquí, siguen siendo fáciles de entender.

class CartaGuerrero extends Carta {
  CartaGuerrero({super.position})
      : super(
          colorFrente: 'marco_guerrero.png',
          reversoPath: 'carta_guerrero.png',
        );
}

class CartaMito extends Carta {
  CartaMito({super.position})
      : super(
          colorFrente: 'marco_mito.png',
          reversoPath: 'carta_mito.png',
        );
}

class CartaLeyenda extends Carta {
  CartaLeyenda({super.position})
      : super(
          colorFrente: 'marco_leyenda.png',
          reversoPath: 'carta_leyenda.png',
        );
}

class CartaDios extends Carta {
  CartaDios({super.position})
      : super(
          colorFrente: 'marco_dios.png',
          reversoPath: 'carta_dios.png',
        );
}
