import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Colores base usados
    const bgColor = Color(0xFF121E2A);
    const containerColor = Color(0xFF1C2633);
    const cyanColor = Color(0xFF00E5FF);
    const cyanDark = Color(0xFF00BCD4);
    const yellowColor = Color(0xFFFFD700);
    const purpleColor = Color(0xFF9C27B0);

    // Lista simulada de amigos online
    final onlineFriends = [
      {'name': 'Jugador1', 'status': 'En línea'},
      {'name': 'Jugador2', 'status': 'En línea'},
      {'name': 'Jugador3', 'status': 'En línea'},
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Usuario y moneda
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: cyanDark,
                          child: Text(
                            'Yo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'lalodandx',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Nivel 50',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: cyanColor),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.currency_exchange,
                                size: 18,
                                color: cyanColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '350',
                                style: TextStyle(
                                  color: cyanColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.settings, color: Colors.white),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Nivel de Temporada
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: cyanColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nivel de Temporada',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cyanColor,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation<Color>(cyanColor),
                          value: 0.6,
                          minHeight: 10,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Nivel 60 - Reclama tus recompensas',
                        style: TextStyle(color: Colors.white38, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Cofre Rápido de Recompensas
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cofre Rápido de Recompensas',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cyanColor,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cofre Diario',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '500 monedas de oro',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cyanColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Reclamar',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Noticias del Juego
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Noticias del Juego',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cyanColor,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 10),

                      // Noticia 1
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: cyanColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Nueva\nTemporada',
                              style: TextStyle(
                                color: bgColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lanzamiento de la Temporada 3',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '¡Nuevas cartas, modos de juego y más te esperan!',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 14),

                      // Noticia 2
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Mantenimiento',
                              style: TextStyle(
                                color: bgColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mantenimiento programado',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'El juego estará en mantenimiento el 25/10/2024 a las 23:00',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),

                // Eventos Disponibles
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eventos Disponibles',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: cyanColor,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _eventCard(
                          'Torneo PvP',
                          'Torneo PvP de la semana',
                          yellowColor,
                          Colors.black,
                        ),
                        _eventCard(
                          'Desafío Coop',
                          'Desafío cooperativo',
                          purpleColor,
                          Colors.white,
                        ),
                        _eventCard(
                          'Jefe Incursión',
                          'Asalto al Jefe de Incursión',
                          cyanColor,
                          Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Nueva sección: Agregar Amigos
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agregar Amigos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cyanColor,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Buscar por nombre de jugador...',
                          hintStyle: TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: Color(0xFF1C2633),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Nueva sección: Amigos en línea
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amigos en línea',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cyanColor,
                          fontSize: 16,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 12),
                      ...onlineFriends.map((friend) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF00BCD4).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: cyanDark,
                                child: Text(
                                  friend['name']!.substring(0, 2).toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  friend['name']!,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Text(
                                friend['status']!,
                                style: TextStyle(
                                  color: cyanColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _eventCard(
    String title,
    String subtitle,
    Color bgColor,
    Color textColor,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 6),
            Text(subtitle, style: TextStyle(color: textColor, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
