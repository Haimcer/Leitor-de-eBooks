import 'package:flutter/material.dart';

import 'iglobals_colors.dart';

class GlobalsColorsLight implements IGlobalsColors {
  @override
  var primaryColor = Color(
      0xFFFFA726); //TODO: QUANDO TROCAR A COR AQUI, AO REPLICAR APP, TROCAR COR DA NOTIFICAÇÃO TAMBÉM NA CLASS HelperNotification
  //var primaryColorLight = Color.fromRGBO(255, 0, 102, 0.85);//Color.fromRGBO(11, 79, 136, 1);//Color.fromRGBO(16, 58, 132, 0.76)
  @override
  var secundaryColor = Color.fromRGBO(102, 187, 106, 1);
  @override
  var tertiaryColor = Color.fromRGBO(255, 255, 255, 1);
  @override
  var backgroundItens = Color.fromRGBO(225, 225, 225, 1);
  //var colorYellow = Color.fromRGBO(255, 221, 0, 1);
  //var colorRed = Color(0xFFEB4545);
  @override
  var textColorForte = Color.fromRGBO(28, 25, 21, 1);
  @override
  var textColorMedio = Color.fromRGBO(121, 121, 121, 1);
  @override
  var textColorFraco = Color.fromRGBO(181, 181, 181, 1);
  @override
  var textColorSecundary = Colors.white;
  @override
  var textColorSecundaryTransp = Colors.white70;

  @override
  var textColorPrimaryInverse = Color.fromRGBO(
      250, 250, 250, 1); //cor que fica em cima da cor primaria e secundaria

  @override
  var sombreado = Color.fromRGBO(0, 0, 0, 0.122);

  @override
  var colorBackgroundImage = "FFA726";

  @override
  var colorGradiente = const LinearGradient(
    colors: [
      Color.fromRGBO(255, 167, 38, 1),
      Color.fromRGBO(255, 167, 38, 0.6),
      Color.fromRGBO(255, 167, 38, 0.3),
      Color.fromRGBO(255, 255, 255, 0) /*, Color.fromRGBO(255, 0, 102, 1)*/
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0, 0.5, 0.8, 1],
  );

  @override
  var colorGradienteBtn = const LinearGradient(
    colors: [
      Color.fromARGB(255, 255, 167, 38),
      Color.fromRGBO(102, 187, 106, 1) /*, Color.fromRGBO(255, 0, 102, 1)*/
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [
      0.5,
      //0.95,
      1
    ],
  );
}
