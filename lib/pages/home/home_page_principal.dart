import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:leitor_ebooks/pages/home/home_page_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/globals_functions.dart';
import '../../globals/globlas_alert.dart';
import '../../globals/theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() {
    if (!entrouIniciaPage) {
      globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(context).alertWarning(context, onTap: () {
        SystemNavigator.pop();
      },
          text:
              "Ops! Parece que você está sem conexão com a internet. \nPor favor, verifique sua conexão e tente novamente.");
      return null;
    }
    prefs = await SharedPreferences.getInstance();
    entrouIniciaPage = true;
    await _iniciaTheme();
  }

  Future _iniciaTheme() async {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    final int? temaApp = prefs.getInt('theme');
    if (!mounted) return;
    setState(() {
      if (temaApp == null) {
        globalsThemeVar.currentThemeMode =
            brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      } else {
        if (temaApp == 0) {
          globalsThemeVar.currentThemeMode = ThemeMode.light;
        } else {
          globalsThemeVar.currentThemeMode = ThemeMode.dark;
        }
      }

      globalsThemeVar.setIGlobalsColors();
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
              child: HomeWidget(context).homePerfilPricipal(context)
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
