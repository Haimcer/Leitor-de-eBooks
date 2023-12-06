import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';

class HomeWidget {
  HomeWidget(this.context);
  BuildContext context;

  Widget homePerfilPricipal(BuildContext contextAux) {
    return ListView(
      shrinkWrap: true,
      children: [GlobalsWidgets(context).topImageWithBlur()],
    );
  }
}
