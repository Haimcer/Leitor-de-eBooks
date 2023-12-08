import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leitor_ebooks/globals/globals_functions.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:leitor_ebooks/pages/home/home_page_functions.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/theme_controller.dart';
import '../../modals/modal_livro.dart';

class HomeWidget {
  HomeWidget(this.context);
  BuildContext context;

  Widget homePerfilPrincipal(BuildContext contextAux) {
    final homeStore = Provider.of<HomeStore>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        homeStore.listModelMobX.isEmpty
            ? GlobalsWidgets(context).imgEmpty()
            : Container(
                margin: EdgeInsets.only(
                  left: GlobalsSizes().marginSize,
                  right: GlobalsSizes().marginSize,
                  top: GlobalsSizes().marginSize / 3,
                ),
                height: MediaQuery.of(context).size.height / 1.4,
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
    final homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    return Observer(builder: (_) {
      livro.setIsDownloadOk(
          homePrincipalFunctions.listDownloads.contains(livro.downloadUrl));
      livro.setFavorite(
          homePrincipalFunctions.listFavorite.contains(livro.downloadUrl));
      return IgnorePointer(
        ignoring: livro.loading ?? false,
        child: GestureDetector(
          onTap: () async {
            if (livro.isDownloadOk == false) {
              if (await GlobalsFunctions().verificaConexao()) {
                GlobalsAlert(context).alertInternet(context);
                return;
              }
            }
            livro.setLoading(true);
            await homePrincipalFunctions.download(livro);

            VocsyEpub.setConfig(
              themeColor: Theme.of(context).primaryColor,
              identifier: 'isbook',
              scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
              allowSharing: true,
              enableTts: true,
              nightMode: globalsThemeVar.currentThemeMode == ThemeMode.light
                  ? false
                  : true,
            );

            if (livro.isDownloadOk ?? false) {
              VocsyEpub.open(
                livro.localDirectory ?? '',
                lastLocation: null,
              );
            }

            livro.setLoading(false);
            if (livro.localDirectory != null || livro.localDirectory != '') {
              livro.setIsDownloadOk(true);
            } else {
              livro.setIsDownloadOk(false);
            }
          },
          child: Container(
            child: Card(
              color: globalsThemeVar.iGlobalsColors.tertiaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlobalsSizes().borderSize),
              ),
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        // Imagem carregada da rede
                        Container(
                          height: 500, // Defina a altura desejada
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(GlobalsSizes().borderSize),
                              topRight:
                                  Radius.circular(GlobalsSizes().borderSize),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: livro.coverUrl ?? '',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                // Exibe um widget de erro se houver problemas no carregamento da imagem
                                return GlobalsWidgets(context)
                                    .loading(size: 25);
                              },
                            ),
                          ),
                        ),
                        // Máscara escura
                        Opacity(
                          opacity: livro.loading ?? false ? 0.5 : 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                topLeft:
                                    Radius.circular(GlobalsSizes().borderSize),
                                topRight:
                                    Radius.circular(GlobalsSizes().borderSize),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: GlobalsSizes().marginSize / 2,
                            right: GlobalsSizes().marginSize / 2,
                            top: GlobalsSizes().marginSize / 4,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.circleCheck,
                                color: livro.isDownloadOk ?? false
                                    ? Colors.green.withOpacity(1)
                                    : Colors.green.withOpacity(0),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (livro.favorite ?? false) {
                                    livro.setFavorite(false);
                                    homePrincipalFunctions.listFavorite
                                        .remove(livro.downloadUrl ?? '');
                                    await GlobalsLocalStorage().setFavorite(
                                        listFavorite: homePrincipalFunctions
                                            .listFavorite);
                                  } else {
                                    livro.setFavorite(true);
                                    homePrincipalFunctions.listFavorite
                                        .add(livro.downloadUrl ?? '');
                                    await GlobalsLocalStorage().setFavorite(
                                        listFavorite: homePrincipalFunctions
                                            .listFavorite);
                                  }
                                },
                                child: livro.favorite ?? false
                                    ? const Icon(
                                        FontAwesomeIcons.solidBookmark,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.bookmark,
                                        color: globalsThemeVar
                                            .iGlobalsColors.textColorFraco,
                                      ),
                              ),
                            ],
                          ),
                        ),
                        // Indicador de progresso
                        livro.loading ?? false
                            ? Observer(
                                builder: (context) {
                                  return GlobalsWidgets(context)
                                      .loading(size: 25);
                                },
                              )
                            : Container(),
                      ],
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
        ),
      );
    });
  }
}
