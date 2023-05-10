import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:runi_app/l10n/l10n.dart';
import 'package:runi_app/models/change_hp_notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteSettingsWidget extends StatefulWidget {
  const FavoriteSettingsWidget({super.key});

  @override
  State<FavoriteSettingsWidget> createState() => _FavoriteState();
}

class _FavoriteState extends State<FavoriteSettingsWidget> {
  final Future<SharedPreferences> _fav = SharedPreferences.getInstance();
  late Future<List<String>> _listFav;
  final TextEditingController _textControl = TextEditingController();

  @override
  void dispose() {
    _textControl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listFav = _fav.then((SharedPreferences fav) {
      return fav.getStringList('favorite') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(context.l10n.favoriteSettings),
      initiallyExpanded: true,
      leading: const Icon(
        Icons.favorite,
        size: 36,
      ),
      children: [
        ListTile(
          visualDensity: const VisualDensity(vertical: -3),
          leading: const Icon(
            Icons.add_circle_outline,
            size: 20,
          ),
          title: SizedBox(
            width: 70,
            height: 56,
            child: TextField(
              controller: _textControl,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                _addFav(value);
                _textControl.clear();
              },
            ),
          ),
        ),
        FutureBuilder<List<String>>(
          future: _listFav,
          builder: (
            BuildContext context,
            AsyncSnapshot<List<String>> snapshot,
          ) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return ListTile(
                    leading: const Icon(
                      Icons.error_outline,
                      size: 25,
                    ),
                    title: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  return listView(snapshot.data ?? []);
                }
            }
          },
        )
      ],
    );
  }

  Widget listView(List<String> listFav) {
    final listViewer = <Widget>[];
    for (final fav in listFav) {
      listViewer.add(
        ListTile(
          visualDensity: const VisualDensity(vertical: -3),
          trailing: IconButton(
            icon: const Icon(
              size: 20,
              Icons.delete,
            ),
            onPressed: () => _removeFav(fav),
          ),
          onTap: () => ChangeHpNotification(fav).dispatch(context),
          title: Text(fav),
        ),
      );
    }
    return Column(
      children: listViewer,
    );
  }

  Future<void> _addFav(String newFav) async {
    final fav = await _fav;
    final listFav = fav.getStringList('favorite') ?? [];

    if (listFav.length >= 3 && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.tooManyFavorite)),
      );
    }

    if (!listFav.contains(newFav) && listFav.length < 3) {
      listFav.add(newFav);
      setState(() {
        _listFav = fav.setStringList('favorite', listFav).then((bool success) {
          return listFav;
        });
      });
    }
  }

  Future<void> _removeFav(String favToRemove) async {
    final fav = await _fav;
    final listFav = fav.getStringList('favorite') ?? [];

    if (listFav.contains(favToRemove)) {
      listFav.remove(favToRemove);
      setState(() {
        _listFav = fav.setStringList('favorite', listFav).then((bool success) {
          return listFav;
        });
      });
    }
  }
}
