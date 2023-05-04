import 'package:flutter/material.dart';
import 'package:runi_app/models/player.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          IconButton(
            iconSize: 72,
            color: Colors.black54,
            icon: const Icon(Icons.add),
            onPressed: increaseHp,
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
            icon: const Icon(Icons.remove),
            onPressed: decreaseHp,
          ),
        ],
      ),
    );
  }

  void decreaseHp() {
    setState(() {
      widget.player.decreaseHp();
    });
  }

  void increaseHp() {
    setState(() {
      widget.player.increaseHp();
    });
  }
}
