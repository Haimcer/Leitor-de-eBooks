import 'package:flutter/material.dart';
import 'iglobals_colors.dart';

class GlobalsColorsDark implements IGlobalsColors {
  @override
  var primaryColor = Color.fromRGBO(255, 167, 38, 1);
  //var primaryColorLight = Color.fromRGBO(255, 0, 102, 0.85);//Color.fromRGBO(11, 79, 136, 1);//Color.fromRGBO(16, 58, 132, 0.76)
  @override
  var secundaryColor = Color.fromRGBO(102, 187, 106, 1);
  @override
  var tertiaryColor = Color.fromRGBO(77, 77, 77, 1);

  @override
  var backgroundItens = Color.fromRGBO(50, 50, 50, 1);

  @override
  var textColorForte = Colors.white;
  @override
  var textColorMedio = Color.fromRGBO(203, 203, 203, 1);
  @override
  var textColorFraco = Color.fromRGBO(155, 155, 155, 1);
  @override
  var textColorSecundary = Color.fromRGBO(50, 50, 50, 1);
  @override
  var textColorSecundaryTransp = const Color.fromRGBO(77, 77, 77, 0.7);

  @override
  var textColorPrimaryInverse = Color.fromRGBO(233, 233, 233, 1);

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
      Color.fromRGBO(255, 167, 38, 1),
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
