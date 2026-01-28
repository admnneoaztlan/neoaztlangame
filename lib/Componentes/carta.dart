import 'package:flame/components.dart';
import 'package:flame/events.dart'; // NECESARIO PARA DRAG
import 'package:flutter/material.dart';

// Definimos un tamaño constante para todas las cartas.
final cartaSize = Vector2(60, 90);

// Agregamos DragCallbacks y HasGameRef
class Carta extends PositionComponent with DragCallbacks, HasGameRef {
  final String colorFrente;
  final String reversoPath;
  bool mostrandoFrente = false;

  late final Paint paint;

  // Variable para almacenar el Sprite cargado.
  Sprite? reversoSprite;
  Sprite? frentePaint;

  // Variables para la lógica de arrastre
  bool isDragging = false;
  Vector2? _posicionOriginal;
  int _prioridadOriginal = 0;

  Carta({
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
    // Carga de imágenes (igual que antes)
    if (reversoPath != 'default_reverso.png') {
      try {
        reversoSprite = await Sprite.load('cartas/$reversoPath');
      } catch (e) {
        print('ERROR carta reverso: $e');
      }
    }

    if (colorFrente != 'default_frente.png') {
      try {
        frentePaint = await Sprite.load('cartas/$colorFrente');
      } catch (e) {
        print('ERROR carta frente: $e');
      }
    }
    return super.onLoad();
  }

  void voltear() {
    mostrandoFrente = !mostrandoFrente;
  }

  // --- LÓGICA DE ARRASTRE (DRAG & DROP) ---

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    // Solo permitimos arrastrar si está de frente (es nuestra)
    // O si quieres permitir arrastrar siempre, quita el if.
    if (!mostrandoFrente) return;

    isDragging = true;
    _posicionOriginal = position.clone(); // Guardamos donde estaba
    _prioridadOriginal = priority;
    priority = 100; // La traemos al frente de todo para que no se oculte
    scale = Vector2.all(1.2); // Hacemos que crezca un poco al agarrarla
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (!isDragging) return;
    // Movemos la carta sumando el movimiento del dedo
    // parentToLocal convierte el movimiento global a coordenadas locales
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    if (!isDragging) return;

    isDragging = false;
    scale = Vector2.all(1.0); // Tamaño normal
    priority = _prioridadOriginal; // Prioridad normal

    // --- DETECCIÓN DE DROP (SOLTAR) ---
    // Usamos 'dynamic' para evitar import circular con Playscreen
    final playscreen = gameRef as dynamic;

    // Obtenemos la Zona de Batalla (zona2)
    final zonaBatalla = playscreen.zona2;

    // Verificamos colisión:
    // Convertimos la posición de la carta a coordenadas globales
    final cartaRectGlobal = toAbsoluteRect();
    final batallaRectGlobal = zonaBatalla.toAbsoluteRect();

    // ¿Se tocan?
    if (cartaRectGlobal.overlaps(batallaRectGlobal)) {
      print("¡CARTA JUGADA EN BATALLA!");

      // AQUÍ VA LA LÓGICA DE JUEGO (Mover la carta de lista, restar maná, etc)
      // Por ahora, para probar, la dejamos en la zona de batalla visualmente:

      // 1. La quitamos de su padre actual (ZonaUsuario)
      removeFromParent();

      // 2. Ajustamos su posición para que quede dentro de la zona de batalla
      // (Esto es un cálculo rápido para centrarla relativa a la nueva zona)
      position = Vector2(zonaBatalla.size.x / 2, zonaBatalla.size.y / 2);

      // 3. La agregamos a la ZonaBatalla
      zonaBatalla.add(this);

    } else {
      // Si la soltamos fuera, regresa a su lugar
      if (_posicionOriginal != null) {
        position = _posicionOriginal!;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    // Renderizado igual que antes
    if (mostrandoFrente) {
      if (frentePaint != null) {
        frentePaint!.render(canvas, size: size, overridePaint: paint);
      } else {
        canvas.drawRect(size.toRect(), paint);
      }
    } else {
      if (reversoSprite != null) {
        reversoSprite!.render(canvas, size: size, overridePaint: paint);
      } else {
        canvas.drawRect(size.toRect(), paint);
      }
    }
  }
}

// Las subclases (Guerrero, Mito, etc) se quedan igual abajo...
class CartaGuerrero extends Carta {
  CartaGuerrero({super.position})
      : super(colorFrente: 'marco_guerrero.png', reversoPath: 'carta_guerrero.png');
}
class CartaMito extends Carta {
  CartaMito({super.position})
      : super(colorFrente: 'marco_mito.png', reversoPath: 'carta_mito.png');
}
class CartaLeyenda extends Carta {
  CartaLeyenda({super.position})
      : super(colorFrente: 'marco_leyenda.png', reversoPath: 'carta_leyenda.png');
}
class CartaDios extends Carta {
  CartaDios({super.position})
      : super(colorFrente: 'marco_dios.png', reversoPath: 'carta_dios.png');
}