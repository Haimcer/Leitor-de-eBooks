import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:provider/provider.dart';
import 'globals_sizes.dart';
import 'globals_widgets.dart';

class GlobalsButtons {
  BuildContext context;
  GlobalsButtons(this.context);

  Widget btnVoltarFundo(BuildContext _context,
      {Color? corFundo,
      Color? corIcon,
      VoidCallback? onTap,
      IconData? icon,
      double? paddingAll}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(_context);
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pop(_context);
          },
      child: Container(
        padding: EdgeInsets.only(
          left: paddingAll ?? 8,
          bottom: paddingAll ?? 8,
          right: paddingAll ?? 8,
          top: paddingAll ?? 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              GlobalsSizes().borderSize,
            ),
          ),
          color: corFundo ?? globalsThemeVar.iGlobalsColors.primaryColor,
        ),
        child: Icon(
          icon ?? Icons.arrow_back_ios,
          color:
              corIcon ?? globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
          size: GlobalsSizes().sizeTitulo,
        ),
      ),
    );
  }

  // BOTAO GLOBAL
  //
  Widget buttonPrimary(corBtn, corText, String text, VoidCallback? onTap,
      {double? paddingHoriz,
      double? paddingVert,
      double? marginHoriz,
      IconData? iconSuf,
      Widget? prefix,
      Color? corBorda,
      bool isSombreado = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: paddingHoriz ?? 7, vertical: paddingVert ?? 7),
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
            horizontal: marginHoriz ?? GlobalsSizes().marginSize),
        decoration: BoxDecoration(
            boxShadow: [
              isSombreado
                  ? GlobalsWidgets(context).sombreadoBoxShadow()
                  : BoxShadow(),
            ],
            color: corBtn,
            borderRadius:
                BorderRadius.all(Radius.circular(GlobalsSizes().borderSize)),
            border: Border.all(
                color: corBorda ?? Colors.transparent,
                style: BorderStyle.solid,
                width: corBorda == null ? 0 : 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            prefix ?? Container(),
            prefix != null ? const SizedBox(width: 7) : Container(),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: corText,
                  fontSize: GlobalsSizes().sizeSubtitulo,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            iconSuf != null ? const SizedBox(width: 7) : Container(),
            iconSuf != null
                ? Icon(iconSuf,
                    size: GlobalsSizes().sizeSubtitulo, color: corText)
                : Container()
          ],
        ),
      ),
    );
  }
}
