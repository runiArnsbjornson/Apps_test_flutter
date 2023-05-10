import 'dart:math';
import 'package:flutter/material.dart';
import 'package:runi_app/l10n/l10n.dart';
import 'package:runi_app/models/change_hp_notification.dart';
import 'package:runi_app/models/i_hp_notification.dart';
import 'package:runi_app/models/player.dart';
import 'package:runi_app/models/reset_hp_notification.dart';
import 'package:runi_app/widgets/menu_widget.dart';
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
    return NotificationListener<IHpNotification>(
      onNotification: (notification) {
        if (notification is ResetHpNotification) {
          _handleResetHp();
        }
        if (notification is ChangeHpNotification) {
          _handleChangeHp(notification.value);
        }
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.appName),
        ),
        drawer: const MenuWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Transform.rotate(
                  angle: pi,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: PlayerWidget(
                      color: Colors.blue,
                      player: p1,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: PlayerWidget(
                    color: Colors.red,
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

  void _handleResetHp() {
    setState(() {
      p1.reset();
      p2.reset();
    });
  }

  void _handleChangeHp(String setHp) {
      p1.startHp = int.parse(setHp);
      p2.startHp = int.parse(setHp);
     _handleResetHp();
  }
}
