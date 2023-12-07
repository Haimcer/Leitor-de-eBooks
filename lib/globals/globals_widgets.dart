import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_sizes.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'theme_controller.dart';

class GlobalsWidgets {
  GlobalsWidgets(this.context);
  BuildContext context;

  BoxShadow sombreadoBoxShadow() {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return BoxShadow(
      color: globalsThemeVar.iGlobalsColors.sombreado,
      blurRadius: 15.0,
      spreadRadius: 0.2,
      offset: const Offset(
        2.0,
        3.0,
      ),
    );
  }

  Widget imgEmpty({double? sizew, String? text, Widget? richtext}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: sizew ?? MediaQuery.of(context).size.width / 1.8,
          child: Image.asset('assets/img_error.png'),
        ),
        Container(
          margin: EdgeInsets.all(GlobalsSizes().marginSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: richtext ??
                      Text(
                        text ?? 'Ops! Nada por aqui',
                        style: TextStyle(
                            color:
                                globalsThemeVar.iGlobalsColors.textColorMedio,
                            fontSize: GlobalsSizes().sizeTextMedio),
                        textAlign: TextAlign.center,
                      )),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget tituloPageComVoltar(BuildContext contextAux, String text,
      {Widget? sufixo}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Row(
      children: [
        //barra lateral
        IconButton(
            onPressed: () {
              Navigator.of(contextAux).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: globalsThemeVar.iGlobalsColors.textColorFraco,
              size: GlobalsSizes().sizeTitulo,
            )),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.textColorFraco,
                    fontSize: GlobalsSizes().sizeTitulo,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        sufixo ?? Container()
      ],
    );
  }

  Widget divisoria() {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Divider(
      color: globalsThemeVar.iGlobalsColors.textColorMedio,
      endIndent: GlobalsSizes().marginSize,
      indent: GlobalsSizes().marginSize,
    );
  }

  Widget loading({double? size}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: globalsThemeVar.iGlobalsColors.primaryColor,
        rightDotColor: globalsThemeVar.iGlobalsColors.secundaryColor,
        size: size ?? 70,
      ),
    );
  }

  Widget appBarDescTitulo(BuildContext contextAux,
      {double? sizeH,
      double? sizeW,
      Widget? prefixWidget,
      Widget? sufixWidget,
      String? titulo,
      String? descTitulo,
      double? marginBottomTitle,
      String? urlImg}) {
    // final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final sizeMediaQ = MediaQuery.of(contextAux).size;
    return SizedBox(
      height: sizeH ?? sizeMediaQ.width / 2.5,
      width: sizeW ?? sizeMediaQ.width,
      child: Stack(
        children: [
          Container(
            height: sizeH ?? sizeMediaQ.width / 2.5,
            width: sizeW ?? sizeMediaQ.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(GlobalsSizes().borderSize * 2.5)),
              image: urlImg == null || urlImg == 'null'
                  ? const DecorationImage(
                      image: AssetImage("assets/img_capa.jpg"),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: NetworkImage(urlImg),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: sizeH ?? sizeMediaQ.width / 2.5,
            width: sizeW ?? sizeMediaQ.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(GlobalsSizes().borderSize * 2.5)),
                color: Colors.black54),
          ),
          Container(
            margin: EdgeInsets.all(GlobalsSizes().marginSize),
            child: Column(
              children: [
                prefixWidget == null && sufixWidget == null
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          prefixWidget ?? Container(),
                          sufixWidget ?? Container(),
                        ],
                      ),
                Expanded(
                  child: titulo == null
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              descTitulo ?? '',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: GlobalsSizes().sizeTextMedio,
                                //fontWeight: GlobalsStyles().negritoFont,
                              ),
                            ),
                            Text(
                              titulo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: GlobalsSizes().sizeSubtitulo,
                                fontWeight: GlobalsStyles(context).negritoFont,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: marginBottomTitle ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
