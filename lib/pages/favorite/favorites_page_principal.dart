import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/pages/home/home_page_widget.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'favorites_page_functions.dart';
import 'favorites_page_widget.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  late FavoritePrincipaFunctions favoritePrincipalFunction;
  late GlobalsStore globalsStore;
  late HomeStore homeStore;
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    favoritePrincipalFunction = Provider.of<FavoritePrincipaFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    homeStore = Provider.of<HomeStore>(context);
    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;
    await favoritePrincipalFunction.favoritePrincipalFunction(
        globalsStore, homeStore);
    if (!mounted) return;
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      body: Stack(
        //usado para que o carregamento feito depois que a página foi aberta fique sempre por cima
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child:
                  carregando //verificador para ficar na tela de loading enquanto a pagina esta sendo carregada
                      ? GlobalsWidgets(context).loading()
                      : FavoriteWidget(context).favoritePricipal(context)),
          Observer(builder: (_) {
            return Visibility(
                visible: globalsStore.loading,
                child: GlobalsWidgets(context).loading());
          }),
        ],
      ),
    );
  }
}
