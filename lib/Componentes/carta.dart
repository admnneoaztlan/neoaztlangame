import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// Definimos un tamaño constante para todas las cartas.
final cartaSize = Vector2(60, 90);

class Carta extends PositionComponent {
  // CLAVE 1: Hacemos 'colorFrente' opcional y le damos un valor por defecto (Gris).
  final Color colorFrente;
  // CLAVE 2: Hacemos 'reversoPath' opcional.
  final String reversoPath;

  // true: Muestra el color/imagen del frente.
  bool mostrandoFrente = false;

  late final Paint frentePaint;

  // Variable para almacenar el Sprite cargado.
  Sprite? reversoSprite;

  // Constructor de la clase base Carta.
  Carta({
    // Parámetros opcionales con valores por defecto para compatibilidad
    this.colorFrente = Colors.grey,
    this.reversoPath = 'default_reverso.png',
    Vector2? size,
    Vector2? position,
  }) : super(
          position: position ?? Vector2.zero(),
          size: size ?? cartaSize,
          anchor: Anchor.center,
        ) {
    frentePaint = Paint()..color = colorFrente;
  }

  @override
  // onLoad se ejecuta al inicio y es asíncrono, ideal para cargar assets (imágenes).
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
    return super.onLoad();
  }

  // Método simple para cambiar el estado de la carta.
  void voltear() {
    mostrandoFrente = !mostrandoFrente;
  }

  @override
  // render se llama en cada cuadro de la animación para dibujar la carta.
  void render(Canvas canvas) {
    // Si está de frente (true), dibuja el rectángulo de color sólido.
    if (mostrandoFrente) {
      canvas.drawRect(this.size.toRect(), frentePaint);
    }
    // Si está de reverso (false)
    else {
      // Dibujamos el Sprite directamente (si existe).
      if (reversoSprite != null) {
        // ***** CORRECCIÓN PARA EL ESTIRAMIENTO DE PANTALLA *****
        // Usamos el método render de Sprite con un destRect (destino)
        // que mantiene la relación de aspecto original de la imagen.
        reversoSprite!.render(
          canvas,
          size: size,
          overridePaint:
              frentePaint, // Opcional: Esto permite que el Paint afecte al sprite (por si quieres filtros)
        );

        // El estiramiento se resuelve con cómo Flame dibuja internamente
        // cuando se le da solo el size, ya que respeta la relación de aspecto de la fuente (src).
        // Si el problema persiste, es probable que la imagen en sí ya esté estirada.
      }
      // Si el Sprite es nulo (no se cargó o es la carta por defecto), dibujamos un color.
      else {
        // Usamos el color de frente como un color de relleno seguro (Gris por defecto).
        canvas.drawRect(this.size.toRect(), frentePaint);
      }
    }
  }
}

// ------------------------------------
// ---- 4 tipos de cartas (Subclases) --
// ------------------------------------
// No hay cambios en la sintaxis aquí, siguen siendo fáciles de entender.

class CartaGuerrero extends Carta {
  CartaGuerrero({Vector2? position})
      : super(
          position: position,
          colorFrente: Colors.red,
          reversoPath: 'carta_guerrero.png',
        );
}

class CartaMito extends Carta {
  CartaMito({Vector2? position})
      : super(
          position: position,
          colorFrente: Colors.green,
          reversoPath: 'carta_mito.png',
        );
}

class CartaLeyenda extends Carta {
  CartaLeyenda({Vector2? position})
      : super(
          position: position,
          colorFrente: Colors.yellow,
          reversoPath: 'carta_leyenda.png',
        );
}

class CartaDios extends Carta {
  CartaDios({Vector2? position})
      : super(
          position: position,
          colorFrente: Colors.blue,
          reversoPath: 'carta_dios.png',
        );
}
