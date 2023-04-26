import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Player p1 = Player(2, 20);
  final Player p2 = Player(2, 20);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Runi app'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                ),
                child: Text(
                  'Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: IconButton(
                  iconSize: 36,
                  icon: const Icon(
                    Icons.cached,
                  ),
                  onPressed: _resetPlayers,
                ),
                title:  const AlertReset(),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: PlayerWidget(
                    color: Colors.red,
                    player: p1,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: PlayerWidget(
                    color: Colors.blue,
                    player: p2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetPlayers() {
    setState(() {
      p1.reset();
      p2.reset();
    });
  }
}

class Player {
  Player(this.id, this.startHp) : hp = startHp;

  final int id;
  int startHp;
  int hp;

  void reset() {
    hp = startHp;
  }
}

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key, required this.color, required this.player});

  final Color color;
  final Player player;

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: <Widget>[
          IconButton(
            iconSize: 72,
            color: Colors.black54,
            icon: const Icon(Icons.remove),
            onPressed: () => setState(() {
              widget.player.hp--;
            }),
          ),
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Text(
                    widget.player.hp.toString(),
                    style: TextStyle(
                      fontSize: constraints.maxHeight >= 100 ? 100 : 54,
                    ),
                  );
                },
              ),
            ),
          ),
          IconButton(
            iconSize: 72,
            color: Colors.black54,
            icon: const Icon(Icons.add),
            onPressed: () => setState(() {
              widget.player.hp++;
            }),
          ),
        ],
      ),
    );
  }
}

class AlertReset extends StatelessWidget {
  const AlertReset({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Reset'),
          content: const Text('Are you sure ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Reset');
         //       _resetPlayer;
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
      child: const Text(
        'Reset HP',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
