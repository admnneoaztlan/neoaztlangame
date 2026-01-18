import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neoaztlan/Componentes/carta.dart';
import 'package:neoaztlan/Componentes/avatar.dart';

class ZonaOponente extends PositionComponent{
  Avatar avatar = Avatar();
  TextComponent avatarText = TextComponent();
  TextComponent vidaText = TextComponent();



  List<Carta> mano =[];
  TextComponent manoText = TextComponent();
  int vidaActual =30;
  int vidaMaxima = 30;
  ZonaOponente() : super(position: Vector2.zero(), size: Vector2(800, 400));
  @override
  Future<Void> onLoad() async{
    super.onLoad();
    avatar.paint.color = Colors.red.shade900;
    add(avatar);
    avatarText = _crearTexto('Oponente', 0.05 * size.y, Colors.purpleAccent, Anchor.center, isNeon: true);
    add(avatarText);
    vidaText = _crearTexto('Vida $vidaActual/$vidaMaxima',0.06 * size.y, Colors.redAccent, Anchor.topCenter, isNeon: true);
    add (vidaText);
    _CrearManoOcultar();
  }
  void _CrearManoOcultar(){
    for (int i = 0; i <4; i++){
      Carta c = Carta(position: Vector2.zero());
      mano .add(c);
      add (c);
    }
  }
  @override
  void onGameResize(Vector2 size){
    super.onGameResize(size);
    this.size = size;
    reacomodar();
  }

  void reacomodar(){
    final zonaW = size.x;
    final zonaH = size.y;
    final avatarArea = Rect.fromLTWH(zonaW *0.75, zonaH *0.1 , zonaW * 0.20, zonaH *0.50);
    (avatar as PositionComponent).size = Vector2(avatarArea.width,avatarArea.height);
    (avatar as PositionComponent).size = Vector2(avatarArea.left, avatarArea.top);
    avatarText.position = Vector2(avatarArea.center.dx, avatarArea.bottom +10);
    vidaText.position = Vector2(avatarArea.center.dx, avatarArea.top -20 );
    final manoArea = Rect.fromLTWH(zonaW * 0.1, zonaH *0.1, zonaW * 0.6, zonaH *0.4);
    _acomondarCartasCurva(mano,centro: Vector2(manoArea.center.dx, manoArea.top), ancho: manoArea.width);
  }
  TextComponent _crearTexto(String t, double s, Color c, Anchor a, {bool isNeon = false}){
    TextStyle st = TextStyle(color: c, fontSize: s);
    if(isNeon) st = st.copyWith(shadows: [Shadow(blurRadius: 8,color: c.withOpacity(0.9))], fontWeight: FontWeight.bold);
    return TextComponent(text: t, anchor: a, textRenderer: TextPaint(style: st));
  }

  void _acomondarCartasCurva(List <Carta> l, {required Vector2 centro, required double ancho}){
    final n = l.length; if (n==0) return;
    final esp = ancho/(n-1);
    for (int i)
  }
}