import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
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

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        title: Text(widget.title,
            style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.textColorForte)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
