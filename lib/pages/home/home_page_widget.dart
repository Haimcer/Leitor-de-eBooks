import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/pages/home/home_page_functions.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../globals/globals_sizes.dart';
import '../../modals/modal_livro.dart';

class HomeWidget {
  HomeWidget(this.context);
  BuildContext context;

  Widget homePerfilPrincipal(BuildContext contextAux) {
    final homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: GlobalsSizes().marginSize,
            right: GlobalsSizes().marginSize,
            top: GlobalsSizes().marginSize / 3,
          ),
          height: MediaQuery.of(context).size.height,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.5,
            ),
            itemCount: homePrincipalFunctions.fichasListModel.length,
            itemBuilder: (context, index) {
              return _buildFilmeCard(
                homePrincipalFunctions.fichasListModel[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilmeCard(LivrosModal filme) {
    return GestureDetector(
      onTap: () {
        _openEpubViewer(filme);
      },
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlobalsSizes().borderSize),
          ),
          elevation: 2.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(GlobalsSizes().borderSize),
                    topRight: Radius.circular(GlobalsSizes().borderSize),
                  ),
                  child: Image.network(
                    filme.coverUrl ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filme.title ?? '',
                      style: GlobalsStyles(context).styleSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      filme.author ?? '',
                      style: GlobalsStyles(context).styleMenor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para abrir o visualizador EPUB
  void _openEpubViewer(LivrosModal filme) {
    // Remova a parte específica da extensão do arquivo
    String epubIdentifier = _removeFileExtension(filme.downloadUrl ?? '');

    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: 'qualquer coisa',
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    VocsyEpub.open(
      epubIdentifier,
      lastLocation: EpubLocator.fromJson({
        "bookId": "2239",
        "href": "/OEBPS/ch06.xhtml",
        "created": 1539934158390,
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }), // first page will open up if the value is null
    );

    VocsyEpub.locatorStream.listen((locator) {
      print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
      // Salve o locator no seu banco de dados para recuperar mais tarde
    });
  }

// Função para remover a parte específica da extensão do arquivo
  String _removeFileExtension(String url) {
    // Encontrar o índice do último caractere que não seja uma letra ou número (considerando como o ponto de separação da extensão)
    int lastNonAlphanumeric = url.lastIndexOf(RegExp(r'[^a-zA-Z0-9]'));

    // Se houver um caractere não alfanumérico, retornar a parte da URL antes desse caractere, caso contrário, retornar a URL original
    return lastNonAlphanumeric != -1
        ? url.substring(0, lastNonAlphanumeric)
        : url;
  }
}
