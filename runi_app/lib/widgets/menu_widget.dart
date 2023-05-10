import 'package:flutter/material.dart';
import 'package:runi_app/l10n/l10n.dart';
import 'package:runi_app/models/change_hp_notification.dart';
import 'package:runi_app/widgets/favorite_settings_widget.dart';
import 'package:runi_app/models/reset_hp_notification.dart';
import 'package:runi_app/widgets/dialog/reset_dialog.dart';
import 'package:runi_app/widgets/dialog/set_hp_dialog.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepOrangeAccent,
            ),
            child: Text(
              context.l10n.drawerMenu,
              style: const TextStyle(
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
              builder: (_) => ResetDialog(
                resetOnConfirm: () => ResetHpNotification().dispatch(context),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 36,
            ),
            title: Text(context.l10n.hpSetButtonText),
            onTap: () => showDialog<void>(
              context: context,
              builder: (_) => SetHpDialog(
                onChangeHp: (newHpValue) =>
                    ChangeHpNotification(newHpValue).dispatch(context),
              ),
            ),
          ),
          const FavoriteSettingsWidget(),
        ],
      ),
    );
  }
}
