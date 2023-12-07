import 'package:flutter/material.dart';
import 'package:leitor_ebooks/pages/home/home_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;
    await homePrincipalFunctions.homeFunctionPrincipal();
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
              child: HomeWidget(context).homePerfilPrincipal(context)
              // carregando //verificador para ficar na tela de loading enquanto a pagina esta sendo carregada
              //     ? GlobalsLoadingWidget(context).loagingPageInicio(
              //         MediaQuery.of(context).size.height,
              //         MediaQuery.of(context).size.width)
              //     :
              ),
          // Observer(builder: (_) {
          //   return Visibility(
          //       visible: globalsStore.loading,
          //       child: GlobalsLoadingWidget(context).loagingPageInicio(
          //           MediaQuery.of(context).size.height,
          //           MediaQuery.of(context).size.width));
          // }),
        ],
      ),
    );
  }
}
