import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../globals/theme_controller.dart';
import '../../globals/globals_buttons.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/globals_widgets.dart';

// ignore: must_be_immutable
class TelaErroPage extends StatelessWidget {
  TelaErroPage({super.key, required this.text});
  String text;

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                GlobalsWidgets(context).imgEmpty(
                  text: text,
                ),
                GlobalsButtons(context).buttonPrimary(
                  globalsThemeVar.iGlobalsColors.secundaryColor,
                  globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
                  'Sair',
                  marginHoriz: GlobalsSizes().marginSize * 4,
                  () {
                    SystemNavigator.pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
