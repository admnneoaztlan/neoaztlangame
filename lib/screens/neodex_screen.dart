import 'package:flutter/material.dart';

class NeodexScreen extends StatefulWidget {
  @override
  _NeodexScreenState createState() => _NeodexScreenState();
}

class _NeodexScreenState extends State<NeodexScreen> {
  final List<Map<String, String>> allCards = List.generate(20, (index) {
    return {
      'name': 'Carta ${index + 1}',
      'category': ['General', 'Rara', 'Épica', 'Legendaria'][index % 4],
      'description': 'Descripción detallada de Carta ${index + 1}.',
      'image': 'https://via.placeholder.com/150?text=Carta+${index + 1}',
    };
  });

  String searchQuery = '';
  String selectedCategory = 'Todas';
  List<Map<String, String>> filteredCards = [];
  List<Map<String, String>> deckCards = [];

  final List<String> categories = [
    'Todas',
    'General',
    'Rara',
    'Épica',
    'Legendaria',
  ];

  @override
  void initState() {
    super.initState();
    filteredCards = List.from(allCards);
  }

  void updateSearch(String query) {
    searchQuery = query.toLowerCase();
    filterCards();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    filterCards();
  }

  void filterCards() {
    setState(() {
      filteredCards = allCards.where((card) {
        final matchesName = card['name']!.toLowerCase().contains(searchQuery);
        final matchesCategory =
            selectedCategory == 'Todas' || card['category'] == selectedCategory;
        return matchesName && matchesCategory;
      }).toList();
    });
  }

  void addToDeck(Map<String, String> card) {
    if (!deckCards.contains(card)) {
      setState(() {
        deckCards.add(card);
      });
    }
  }

  void removeFromDeck(Map<String, String> card) {
    setState(() {
      deckCards.remove(card);
    });
  }

  void showCardDetails(Map<String, String> card) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color(0xFF0B141D),
          title: Text(
            card['name']!,
            style: TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(card['image']!),
              SizedBox(height: 10),
              Text(
                card['description']!,
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar', style: TextStyle(color: Colors.cyanAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color bgColor = Color(0xFF0D1117);
    final Color cardBgColor = Color(0xFF141E2B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Color(0xFF0B141D),
        title: Text('NeoDex', style: TextStyle(color: Colors.cyanAccent)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o categoría...',
                hintStyle: TextStyle(color: Colors.white54),
                prefixIcon: Icon(Icons.search, color: Colors.cyanAccent),
                filled: true,
                fillColor: Color(0xFF0B141D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: updateSearch,
            ),
          ),

          // Botones de filtro de categorías
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                return GestureDetector(
                  onTap: () => selectCategory(category),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.cyanAccent : Color(0xFF141E2B),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.cyanAccent
                            : Colors.transparent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category.toUpperCase(),
                        style: TextStyle(
                          color: isSelected
                              ? Color(0xFF0B141D)
                              : Colors.white54,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Previsualización del mazo
          if (deckCards.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Mazo Actual (${deckCards.length})',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: deckCards.length,
                itemBuilder: (context, index) {
                  final card = deckCards[index];
                  return GestureDetector(
                    onTap: () => showCardDetails(card),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                      width: 80,
                      decoration: BoxDecoration(
                        color: cardBgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.cyanAccent),
                      ),
                      child: Stack(
                        children: [
                          Image.network(
                            card['image']!,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () => removeFromDeck(card),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],

          // Lista de cartas filtradas
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3 / 4,
              ),
              itemCount: filteredCards.length,
              itemBuilder: (context, index) {
                final card = filteredCards[index];
                final isInDeck = deckCards.contains(card);
                return GestureDetector(
                  onTap: () => showCardDetails(card),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cardBgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isInDeck
                            ? Colors.cyanAccent
                            : Colors.transparent,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              card['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            card['name']!,
                            style: TextStyle(
                              color: Colors.cyanAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          card['category']!,
                          style: TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: isInDeck ? null : () => addToDeck(card),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isInDeck
                                ? Colors.grey
                                : Colors.cyanAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(isInDeck ? 'Añadida' : 'Añadir'),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
