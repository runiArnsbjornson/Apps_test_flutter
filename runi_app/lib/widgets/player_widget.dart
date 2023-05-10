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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: IconButton(
                  alignment: Alignment.topCenter,
                  iconSize: 72,
                  color: Colors.black54,
                  icon: const Icon(Icons.add),
                  onPressed: increaseHp,
                ),
              ),
              Expanded(
                child: Listener(
                  child: const Icon(
                    Icons.remove,
                    size: 72,
                    color: Colors.black54,
                  ),
                  onPointerPanZoomStart: (event) {
                    print('Pan : ${event.position}');
                    decreaseTenHp();
                  },
                  onPointerDown: (event) {
                    print(event.position);
                    decreaseHp();
                  },
                ),
                // child: IconButton(
                //   alignment: Alignment.bottomCenter,
                //   iconSize: 72,
                //   color: Colors.black54,
                //   icon: const Icon(Icons.remove),
                //   onPressed: decreaseHp,
                // ),
              ),
            ],
          ),
          Center(
            child: FittedBox(
              child: Text(
                widget.player.hp.toString(),
                style: const TextStyle(
                  fontSize: 150,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void decreaseTenHp() => setState(() {
        widget.player.tenHpDecrease();
      });

  void increaseTenHp() => setState(() {
        widget.player.tenHpIncrease();
      });

  void decreaseHp() => setState(() {
        widget.player.decreaseHp();
      });

  void increaseHp() => setState(() {
        widget.player.increaseHp();
      });
}
