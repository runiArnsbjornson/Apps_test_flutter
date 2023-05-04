import 'package:flutter/material.dart';
import 'package:runi_app/l10n/l10n.dart';

class ResetDialog extends StatelessWidget {
  const ResetDialog({super.key, required this.resetOnConfirm});

  final VoidCallback resetOnConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.hpResetButtonText),
      content: Text(context.l10n.warningHpText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.cancelButton),
        ),
        TextButton(
          onPressed: () {
            resetOnConfirm();
            Navigator.pop(context);
          },
          child: Text(context.l10n.hpResetButtonText),
        ),
      ],
    );
  }
}
