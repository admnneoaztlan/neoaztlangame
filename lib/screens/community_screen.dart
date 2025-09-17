import 'package:flutter/material.dart';

class Clan {
  final String name;
  final String description;
  final int members;
  final int activeMembers;
  final int trophies;
  final int victories;
  final Color color;
  final String initials;
  final bool isElite;
  final bool isPrivate;

  Clan({
    required this.name,
    required this.description,
    required this.members,
    required this.activeMembers,
    required this.trophies,
    required this.victories,
    required this.color,
    required this.initials,
    this.isElite = false,
    this.isPrivate = false,
  });
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  List<Clan> myClans = [
    Clan(
      name: 'Titanes del norte',
      description: 'Clan competitivo buscando guerreros activos',
      members: 47,
      activeMembers: 42,
      trophies: 43230,
      victories: 156,
      color: Colors.cyan,
      initials: 'TN',
    ),
  ];

  List<Clan> availableClans = [
    Clan(
      name: 'Jaguar dorado',
      description: 'Clan élite con estrategias avanzadas',
      members: 50,
      activeMembers: 48,
      trophies: 52100,
      victories: 203,
      color: Colors.yellow.shade700,
      initials: 'JD',
      isElite: true,
    ),
    Clan(
      name: 'Águilas salvajes',
      description: 'Clan amigable para jugadores casuales',
      members: 38,
      activeMembers: 35,
      trophies: 38750,
      victories: 89,
      color: Colors.purple,
      initials: 'AS',
    ),
  ];

  String searchQuery = '';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _openCreateClanModal() {
    showDialog(
      context: context,
      builder: (context) {
        String clanName = '';
        String clanDescription = '';
        final _formKey = GlobalKey<FormState>();
        return AlertDialog(
          backgroundColor: Color(0xFF121921),
          title: Text('Crear Clan', style: TextStyle(color: Colors.cyan)),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Nombre del clan',
                      labelStyle: TextStyle(color: Colors.cyan),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyanAccent),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese un nombre';
                      }
                      return null;
                    },
                    onChanged: (val) => clanName = val,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      labelStyle: TextStyle(color: Colors.cyan),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyanAccent),
                      ),
                    ),
                    onChanged: (val) => clanDescription = val,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    myClans.add(
                      Clan(
                        name: clanName,
                        description: clanDescription,
                        members: 1,
                        activeMembers: 1,
                        trophies: 0,
                        victories: 0,
                        color: Colors.cyanAccent,
                        initials: clanName.isNotEmpty
                            ? clanName
                                  .trim()
                                  .split(' ')
                                  .map((e) => e[0])
                                  .take(2)
                                  .join()
                            : 'CL',
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  void _showClanDetails(Clan clan) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color(0xFF121921),
          child: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(maxHeight: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: clan.color,
                      child: Text(
                        clan.initials,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clan.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.cyan,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            clan.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.cyan),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: Text('Miembros'),
                        trailing: Text('${clan.members}'),
                      ),
                      ListTile(
                        title: Text('Miembros activos'),
                        trailing: Text('${clan.activeMembers}'),
                      ),
                      ListTile(
                        title: Text('Trofeos'),
                        trailing: Text('${clan.trophies}'),
                      ),
                      ListTile(
                        title: Text('Victorias'),
                        trailing: Text('${clan.victories}'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyanAccent,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Solicitud de unión enviada'),
                            ),
                          );
                        },
                        child: Text('Unirse al clan'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Clan> get filteredAvailableClans {
    if (searchQuery.isEmpty) return availableClans;
    return availableClans
        .where(
          (c) =>
              c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              c.description.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  Widget clanCard(Clan clan) {
    return GestureDetector(
      onTap: () => _showClanDetails(clan),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFF19232D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: clan.isElite ? Colors.amber : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 4,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: clan.color,
              child: Text(
                clan.initials,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clan.name,
                    style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    clan.description,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                      children: [
                        TextSpan(text: 'Miembros: '),
                        TextSpan(
                          text: '${clan.members} ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '(Activos: ${clan.activeMembers})\n'),
                        TextSpan(text: 'Trofeos: '),
                        TextSpan(
                          text: '${clan.trophies}\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'Victorias: '),
                        TextSpan(
                          text: '${clan.victories}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (clan.isPrivate) Icon(Icons.lock, color: Colors.redAccent),
            if (clan.isElite) Icon(Icons.star, color: Colors.amber),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1117),
      appBar: AppBar(
        backgroundColor: Color(0xFF0B141D),
        title: Text('Clanes', style: TextStyle(color: Colors.cyan)),
        actions: [
          TextButton(
            onPressed: _openCreateClanModal,
            child: Text('Crear', style: TextStyle(color: Colors.cyanAccent)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mis Clanes',
              style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: myClans.length,
                itemBuilder: (context, index) {
                  return clanCard(myClans[index]);
                },
              ),
            ),
            Divider(color: Colors.cyan),
            SizedBox(height: 8),
            Text(
              'Buscar Clanes',
              style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Buscar clan...',
                      hintStyle: TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Color(0xFF19232D),
                      prefixIcon: Icon(Icons.search, color: Colors.cyan),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Acción extra al crear clan, puedes personalizar
                    _openCreateClanModal();
                  },
                  child: Text('Crear'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: filteredAvailableClans.length,
                itemBuilder: (context, index) {
                  return clanCard(filteredAvailableClans[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
