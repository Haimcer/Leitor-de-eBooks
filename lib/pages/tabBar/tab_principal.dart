import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:leitor_ebooks/globals/globals_sizes.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/globals_functions.dart';
import '../../globals/globals_text.dart';
import '../../globals/globals_widgets.dart';
import '../../globals/globlas_alert.dart';
import '../../globals/theme_controller.dart';
import '../home/home_page_principal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabBarPrincipal extends StatefulWidget {
  const TabBarPrincipal({
    super.key,
  });

  @override
  State<TabBarPrincipal> createState() => _TabBarPrincipalState();
}

class _TabBarPrincipalState extends State<TabBarPrincipal> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  bool entrouIniciaPage = false;
  bool carregando = true;

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
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    double appBarHeight = MediaQuery.of(context).size.height / 4;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: GlobalsWidgets(context)
              .appBarDescTitulo(context, titulo: GlobalsText().titleText),
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: globalsThemeVar.iGlobalsColors.primaryColor,
              tabs: <Widget>[
                Tab(
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(FontAwesomeIcons.bookOpen,
                          size: GlobalsSizes().sizeSubtitulo,
                          color: globalsThemeVar.iGlobalsColors.primaryColor),
                      Text('Biblioteca',
                          style: GlobalsStyles(context).styleSubtitle),
                    ],
                  ),
                ),
                Tab(
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(FontAwesomeIcons.bookBookmark,
                          size: GlobalsSizes().sizeSubtitulo,
                          color: globalsThemeVar.iGlobalsColors.primaryColor),
                      Text('Favoritos',
                          style: GlobalsStyles(context).styleSubtitle),
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  HomePage(),
                  Center(
                    child: Text("It's rainy here"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
