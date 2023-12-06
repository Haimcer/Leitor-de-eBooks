import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_sizes.dart';
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

  Widget topImageWithBlur({
    Widget? widgetCenter,
    Widget? widgetTopLeft,
    Widget? widgetTopRight,
    Widget? widgetTopCenter,
    String? imageBackGround,
    double? height,
    double? bottomRight,
    double? bottomLeft,
    bool? mascara,
  }) {
    return Stack(
      children: [
        Container(
          height: height ?? GlobalsSizes().marginSize * 7,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: imageBackGround != null
                  ? DecorationImage(
                      image: NetworkImage(
                        imageBackGround,
                      ),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage(
                        'assets/img_capa.jpg',
                      ),
                      fit: BoxFit.cover,
                    ),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(
                    bottomRight ?? GlobalsSizes().borderSize * 3),
                bottomLeft: Radius.circular(
                    bottomLeft ?? GlobalsSizes().borderSize * 3),
              )),
          child: mascara ?? true
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        bottomRight:
                            Radius.circular(GlobalsSizes().borderSize * 3),
                        bottomLeft:
                            Radius.circular(GlobalsSizes().borderSize * 3),
                      )),
                )
              : Container(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: GlobalsSizes().marginSize,
              vertical: GlobalsSizes().marginSize / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(top: GlobalsSizes().marginSize / 3),
                  child: widgetTopLeft ?? Container()),
              widgetTopCenter ?? Container(),
              widgetTopRight ?? Container(),
            ],
          ),
        ),
        widgetCenter ?? Container(),
      ],
    );
  }
}
