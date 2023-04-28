import 'dart:math';

import 'package:flutter/material.dart';
import 'package:runi_app/l10n/l10n.dart';
import 'package:runi_app/models/player.dart';
import 'package:runi_app/widgets/dialog/reset_dialog.dart';
import 'package:runi_app/widgets/player_widget.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Player p1 = Player(1, 20);
  final Player p2 = Player(2, 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              leading: const Icon(
                Icons.cached,
                size: 36,
              ),
              title: Text(context.l10n.hpResetButtonText),
              onTap: () => showDialog<void>(
                context: context,
                builder: (context) =>
                    ResetDialog(resetOnConfirm: _resetPlayers),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Transform.rotate(
                angle: pi,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: PlayerWidget(
                    color: Colors.blue,
                    player: p1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                child: PlayerWidget(
                  color: Colors.red,
                  player: p2,
                ),
              ),
            ),
          ],
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
