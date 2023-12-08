import 'package:flutter/material.dart';
import 'globals_sizes.dart';
import 'globals_widgets.dart';

class GlobalsButtons {
  BuildContext context;
  GlobalsButtons(this.context);

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
