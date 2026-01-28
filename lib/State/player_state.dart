import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PlayerData{
  final String nombre;
  final String avatarNombre;
  final String correo;
  final String nacionalidad;
  final bool notificacionesActivas;

  final int vidaActual;
  final int vidaMaxima;
  final int nivel;
  final int gemas;
  final int estrellas;
  final int victorias;
  final double tasaVictoria;

  PlayerData({
  required this.nombre,
  required this.avatarNombre,
    required this.correo,
    required this.nacionalidad,
    required this.notificacionesActivas,
    required this.vidaActual,
    required this.vidaMaxima,
    required this.nivel,
    required this.gemas,
    required this.estrellas,
    required this.victorias,
    required this.tasaVictoria,
});
  PlayerData copyWith({
    String? nombre,
    String? avatarNombre,
    String? correo,
    String? nacionalidad,
    bool? notificacionesActivas,
    int? vidaActual,
    int? vidaMaxima,
    int? nivel,
    int? gemas,
    int? estrellas,
    int? victorias,
    double? tasaVictoria,
  }) {
    return PlayerData(
      nombre: nombre ?? this.nombre,
      avatarNombre: avatarNombre ?? this.avatarNombre,
      correo: correo ?? this.correo,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      notificacionesActivas: notificacionesActivas ?? this.notificacionesActivas,
      vidaActual: vidaActual ?? this.vidaActual,
      vidaMaxima: vidaMaxima ?? this.vidaMaxima,
      nivel: nivel ?? this.nivel,
      gemas: gemas ?? this.gemas,
      estrellas: estrellas ?? this.estrellas,
      victorias: victorias ?? this.victorias,
      tasaVictoria: tasaVictoria ?? this.tasaVictoria,
    );
  }
  }
  class PlayerNotifier extends StateNotifier<PlayerData>{
  PlayerNotifier()
    : super(
    PlayerData(nombre: 'Juan Perez',
        avatarNombre: 'JuanKiller',
        correo: 'example@gmail.com',
        nacionalidad: 'Mexico',
        notificacionesActivas: true,
        vidaActual: 30,
        vidaMaxima: 30,
        nivel: 10,
        gemas: 500,
        estrellas: 2000,
        victorias: 1250,
        tasaVictoria: 79.0
    ),
  );

  void updateProfile({
    String? nombre,
    String? avatarNombre,
    String? correo,
    String? nacionalidad,
    bool? notificacionesActivas,
  }){
    state = state.copyWith(
      nombre: nombre,
      avatarNombre: avatarNombre,
      correo: correo,
      nacionalidad: nacionalidad,
      notificacionesActivas: notificacionesActivas,
    );
  }

  void updateHealth(int newHealth){
    state = state.copyWith(vidaActual: newHealth.clamp(0, state.vidaMaxima));
  }
  void updateGems(int newGems){
    state = state.copyWith(gemas: newGems);
  }

  void logout() {
    state = PlayerData(
      nombre: '',
      avatarNombre: '',
      correo: '',
      nacionalidad: '',
      notificacionesActivas: false,
      vidaActual: 0,
      vidaMaxima: 0,
      nivel: 0,
      gemas: 0,
      estrellas: 0,
      victorias: 0,
      tasaVictoria: 0.0,
    );
  }
}

final PlayerProvider = StateNotifierProvider<PlayerNotifier, PlayerData>(
    (ref)=>PlayerNotifier(),
);





