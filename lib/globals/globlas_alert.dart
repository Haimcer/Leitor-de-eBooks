import 'dart:ui';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme_controller.dart';

class GlobalsAlert {
  BuildContext context;
  GlobalsAlert(this.context);

  alertWarning(
    contextAux, {
    String title = '',
    String? text,
    String? confirmBtnText,
    VoidCallback? onTap,
    bool showCancelBtn = true,
    String? cancelBtnText,
    VoidCallback? onTapCancel,
  }) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(contextAux, listen: false);
    CoolAlert.show(
        context: contextAux,
        type: CoolAlertType.warning,
        title: title,
        text: text,
        showCancelBtn: showCancelBtn,
        cancelBtnText: cancelBtnText ?? "Cancelar",
        onCancelBtnTap: onTapCancel ??
            () {
              SystemNavigator.pop();
            },
        confirmBtnText: confirmBtnText ?? "Ok",
        backgroundColor: globalsThemeVar.iGlobalsColors.textColorFraco,
        confirmBtnColor: globalsThemeVar.iGlobalsColors.secundaryColor,
        onConfirmBtnTap: onTap);
  }

  alertError(contextAux, {String? text}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(contextAux, listen: false);
    CoolAlert.show(
      context: contextAux,
      type: CoolAlertType.error,
      text: text,
      backgroundColor: globalsThemeVar.iGlobalsColors.textColorFraco,
      confirmBtnColor: globalsThemeVar.iGlobalsColors.secundaryColor,
    );
  }

  alertDesejaSair(contextAux,
      {String title = '', String? text = '', VoidCallback? onTap}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);

    CoolAlert.show(
      context: contextAux,
      type: CoolAlertType.warning,
      title: title,
      text: text,
      backgroundColor: globalsThemeVar.iGlobalsColors.textColorFraco,
      confirmBtnColor: globalsThemeVar.iGlobalsColors.secundaryColor,
      onConfirmBtnTap: onTap ?? () async {},
      confirmBtnText: "Sim",
      cancelBtnText: "Não",
      showCancelBtn: true,
      cancelBtnTextStyle:
          TextStyle(color: globalsThemeVar.iGlobalsColors.textColorFraco),
    );
  }

  alertInternet(_context) {
    CoolAlert.show(
      context: _context,
      type: CoolAlertType.error,
      title: "Ops. Sem Internet",
      text: "Conecte-se e tente novamente",
    );
  }
}
