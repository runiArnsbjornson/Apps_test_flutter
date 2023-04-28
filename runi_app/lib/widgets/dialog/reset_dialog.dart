import 'package:flutter/material.dart';

class ResetDialog extends StatelessWidget {
  const ResetDialog({super.key, required this.resetOnConfirm});

  final VoidCallback resetOnConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reset'),
      content: const Text('Are you sure ?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            resetOnConfirm();
            Navigator.pop(context, 'Reset');
          },
          child: const Text('Reset'),
        ),
      ],
    );
  }
}
