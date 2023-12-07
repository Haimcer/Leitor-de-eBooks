import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/pages/home/home_page_functions.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/store/globals_store.dart';
import '../../modals/modal_livro.dart';

class HomeWidget {
  HomeWidget(this.context);
  BuildContext context;

  Widget homePerfilPrincipal(BuildContext contextAux) {
    final homeStore = Provider.of<HomeStore>(context);
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
            itemCount: homeStore.listModelMobX.length,
            itemBuilder: (context, index) {
              return _buildLivroCard(
                  homeStore.listModelMobX[index], contextAux);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLivroCard(LivrosModal livro, BuildContext contextAux) {
    final homeStore = Provider.of<HomeStore>(context);
    final homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
    final globalsStore = Provider.of<GlobalsStore>(context);

    return Observer(builder: (_) {
      return GestureDetector(
        onTap: () async {
          await homePrincipalFunctions.download(livro);
          print('olha aqui');
          print(homeStore.filepath);
          if (!globalsStore.loading) {
            VocsyEpub.setConfig(
              themeColor: Theme.of(context).primaryColor,
              identifier: 'isbook',
              scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
              allowSharing: true,
              enableTts: true,
              nightMode: true,
            );

            if (homeStore.filepath != '') {
              VocsyEpub.open(
                homeStore.filepath,
                lastLocation: EpubLocator.fromJson({
                  "bookId": "2239",
                  "href": "/OEBPS/ch06.xhtml",
                  "created": 1539934158390,
                  "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
                }),
              );
            }
          }
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
                    child: CachedNetworkImage(
                      imageUrl: livro.coverUrl ?? '',
                      fit: BoxFit.cover,
                      progressIndicatorBuilder: (context, url, progress) {
                        // Exibe o indicador de carregamento enquanto a imagem está sendo carregada
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        // Exibe um widget de erro se houver problemas no carregamento da imagem
                        return Center(
                          child: Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        livro.title ?? '',
                        style: GlobalsStyles(context).styleSubtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        livro.author ?? '',
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
    });
  }
}
