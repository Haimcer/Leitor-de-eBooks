import 'package:flutter/material.dart';
import 'package:leitor_ebooks/pages/home/home_page_principal.dart';
import 'package:provider/provider.dart';
import 'globals/theme_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<GlobalsThemeVar>(
          create: (context) => GlobalsThemeVar(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalsThemeVar>(
          create: (context) => GlobalsThemeVar(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(
          title: 'deu certo',
        ),
      ),
    );
  }
}
