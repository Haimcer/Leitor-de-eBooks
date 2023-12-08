import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/pages/home/home_page_widget.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'home_page_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  late HomePrincipalFunctions homePrincipalFunctions;
  late GlobalsStore globalsStore;
  late HomeStore homeStore;
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
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
    await homePrincipalFunctions.homeFunctionPrincipal(globalsStore, homeStore);
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
      body: RefreshIndicator(
        color: globalsThemeVar.iGlobalsColors.primaryColor,
        onRefresh: () async {
          homeStore.setListModelMobXClear();
          await homePrincipalFunctions.homeFunctionPrincipal(
              globalsStore, homeStore);
        },
        child: Stack(
          //usado para que o carregamento feito depois que a página foi aberta fique sempre por cima
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                    carregando //verificador para ficar na tela de loading enquanto a pagina esta sendo carregada
                        ? GlobalsWidgets(context).loading()
                        : HomeWidget(context).homePerfilPrincipal(context)),
            Observer(builder: (_) {
              return Visibility(
                  visible: globalsStore.loading,
                  child: GlobalsWidgets(context).loading());
            }),
          ],
        ),
      ),
    );
  }
}
