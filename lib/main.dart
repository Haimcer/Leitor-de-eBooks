import 'package:flutter/material.dart';
import 'package:leitor_ebooks/pages/favorite/favorites_page_functions.dart';
import 'package:leitor_ebooks/pages/favorite/store/favorite_store.dart';
import 'package:leitor_ebooks/pages/home/home_page_functions.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:leitor_ebooks/pages/tabBar/tab_principal.dart';
import 'package:leitor_ebooks/pages/tela_error/tela_error.dart';
import 'package:provider/provider.dart';
import 'globals/store/globals_store.dart';
import 'globals/theme_controller.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return TelaErroPage(
      text:
          'Ops!\n ${details.exception}\n\n Dica:\n Reabra o app novamente para continuar utilizando',
    );
  };
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        //Providers
        Provider<HomePrincipalFunctions>(
          create: (context) => HomePrincipalFunctions(context),
        ),
        Provider<FavoritePrincipaFunctions>(
          create: (context) => FavoritePrincipaFunctions(context),
        ),

        //Store
        Provider<HomeStore>(
          create: (context) => HomeStore(),
        ),
        Provider<FavoriteStore>(
          create: (context) => FavoriteStore(),
        ),
        Provider<GlobalsStore>(
          create: (context) => GlobalsStore(),
        ),
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
        home: TabBarPrincipal(),
      ),
    );
  }
}
