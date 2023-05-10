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
                  child: TouchDetector.plus(
                player: widget.player,
                stateSetter: setState,
              )),
              Expanded(
                child: TouchDetector.minus(
                  player: widget.player,
                  stateSetter: setState,
                ),
              ),
            ],
          ),
          IgnorePointer(
            child: Center(
              child: FittedBox(
                child: Text(
                  widget.player.hp.toString(),
                  style: const TextStyle(
                    fontSize: 150,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TouchDetector extends StatefulWidget {
  const TouchDetector({
    super.key,
    required this.onSingleTap,
    required this.onDoubleTap,
    required this.content,
    required this.stateSetter,
  });

  TouchDetector.minus({
    super.key,
    required Player player,
    required this.stateSetter,
  })  : onSingleTap = player.decreaseHp,
        onDoubleTap = player.tenHpDecrease,
        content = const Align(
          alignment: Alignment.bottomCenter,
          child: Icon(
            Icons.remove,
            size: 72,
            color: Colors.black54,
          ),
        );

  TouchDetector.plus({
    super.key,
    required Player player,
    required this.stateSetter,
  })  : onSingleTap = player.increaseHp,
        onDoubleTap = player.tenHpIncrease,
        content = const Align(
          alignment: Alignment.topCenter,
          child: Icon(
            Icons.add,
            size: 72,
            color: Colors.black54,
          ),
        );

  final VoidCallback onSingleTap;
  final VoidCallback onDoubleTap;
  final Widget content;
  final void Function(VoidCallback) stateSetter;

  @override
  State<TouchDetector> createState() => _TouchDetectorState();
}

class _TouchDetectorState extends State<TouchDetector> {
  int nbPointer = 0;
  bool shouldConsiderNext = true;

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerUp: (event) {
        nbPointer--;
        if (nbPointer == 0 && shouldConsiderNext) {
          widget.stateSetter(() => widget.onSingleTap());
        } else if (nbPointer == 1) {
          widget.stateSetter(() => widget.onDoubleTap());
        }
        shouldConsiderNext = nbPointer <= 0;
      },
      onPointerDown: (event) {
        nbPointer++;
      },
      child: widget.content,
    );
  }
}
