import 'package:flutter/material.dart';

class ShopItem {
  final String title;
  final String subtitle;
  final int price;
  final Color color;
  final String label;
  final String? imageUrl;

  ShopItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.color,
    required this.label,
    this.imageUrl,
  });
}

class ShopScreen extends StatelessWidget {
  final List<ShopItem> featuredItems = [
    ShopItem(
      title: 'Paquete de cartas épicas',
      subtitle: 'Contiene 5 cartas épicas garantizadas',
      price: 1500,
      color: Colors.purple,
      label: 'Paquete Épico',
    ),
    ShopItem(
      title: 'Cofre Legendario',
      subtitle: 'Contiene 1 carta legendaria',
      price: 2500,
      color: Colors.yellow,
      label: 'Cofre Legendario',
    ),
    ShopItem(
      title: 'Token de EXP',
      subtitle: 'Duplica tu EXP por 24 horas',
      price: 500,
      color: Colors.transparent,
      label: 'Token de EXP',
      imageUrl:
          'https://cdn-icons-png.flaticon.com/512/5455/5455983.png', // ejemplo de ícono
    ),
  ];

  final List<ShopItem> dailyItems = [
    ShopItem(
      title: 'Paquete de cartas raras',
      subtitle: 'Contiene 3 cartas raras',
      price: 800,
      color: Colors.cyan,
      label: 'Paquete Raro',
    ),
    ShopItem(
      title: '1000 de oro',
      subtitle: 'Monedas para mejoras',
      price: 150,
      color: Colors.amber,
      label: 'Oro',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B141D),
        title: Row(
          children: [
            Icon(Icons.store, color: Colors.cyan),
            SizedBox(width: 8),
            Text('Tienda', style: TextStyle(color: Colors.cyan)),
            Spacer(),
            Icon(Icons.attach_money, color: Colors.cyan),
            SizedBox(width: 4),
            Text('9,500', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            buildSection('Objetos Destacados', featuredItems),
            SizedBox(height: 16),
            buildSection('Objetos Diarios', dailyItems),
            SizedBox(height: 16),
            Text(
              'Estos objetos solo tienen uso cosmético y no proporcionan ninguna ventaja competitiva. No se incluyen armas con el traje o envoltorio.',
              style: TextStyle(color: Colors.white54, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, List<ShopItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF121921),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.cyan,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.access_time, color: Colors.white54, size: 16),
              SizedBox(width: 4),
              Text('3h 14m 0s', style: TextStyle(color: Colors.white54)),
            ],
          ),
          SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: items.map((item) => buildShopCard(item)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShopCard(ShopItem item) {
    return Container(
      width: 160,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: item.imageUrl != null
                  ? Image.network(item.imageUrl!, height: 40)
                  : Text(
                      item.label,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            item.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            item.subtitle,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.monetization_on, color: Colors.cyan, size: 18),
              SizedBox(width: 4),
              Text(
                '${item.price}',
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              minimumSize: Size(double.infinity, 36),
            ),
            onPressed: () {
              // lógica de compra
            },
            child: Text('Comprar'),
          ),
        ],
      ),
    );
  }
}
