import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_sizes.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:provider/provider.dart';

class GlobalsStyles {
  late BuildContext context;
  final GlobalsThemeVar globalsThemeVar;
  late TextStyle styleTitle;
  late TextStyle styleSubtitle;
  late TextStyle styleMedio;
  late TextStyle styleMenor;
  late dynamic negritoFont;

  GlobalsStyles(this.context)
      : globalsThemeVar = Provider.of<GlobalsThemeVar>(context, listen: false) {
    styleTitle = TextStyle(
        color: globalsThemeVar.iGlobalsColors.primaryColor,
        fontSize: GlobalsSizes().sizeTitulo);
    styleSubtitle = TextStyle(
        fontWeight: FontWeight.w500,
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeSubtitulo);
    styleMedio = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeTextMedio);
    styleMenor = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes().sizeText);
    negritoFont = FontWeight.w500;
  }
}
