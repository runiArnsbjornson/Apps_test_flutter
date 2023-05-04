import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runi_app/l10n/l10n.dart';

class SetHpDialog extends StatelessWidget {
  const SetHpDialog({super.key, required this.onChangeHp});

  final void Function(String) onChangeHp;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.setHpAlert),
      content: Text(context.l10n.warningHpText),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onChangeHp(context.l10n.hpChoice1);
            Navigator.pop(context);
          },
          child: Text(context.l10n.hpChoice1),
        ),
        TextButton(
          onPressed: () {
            onChangeHp(context.l10n.hpChoice2);
            Navigator.pop(context);
          },
          child: Text(context.l10n.hpChoice2),
        ),
        TextButton(
          onPressed: () {
            onChangeHp(context.l10n.hpChoice3);
            Navigator.pop(context);
          },
          child: Text(context.l10n.hpChoice3),
        ),
        SizedBox(
          width: 70,
          child: TextField(
            decoration: InputDecoration(
              hintText: context.l10n.hpChoiceCustom,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSubmitted: (value) {
              onChangeHp(value);
              Navigator.pop(context);
            },
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
