import 'package:flutter/material.dart';
import 'package:runi_app/l10n/l10n.dart';
import 'package:runi_app/page/game_page.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackbarKey,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const GamePage(),
    );
  }
}
