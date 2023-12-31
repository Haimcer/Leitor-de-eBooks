import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/pages/favorite/store/favorite_store.dart';
import 'package:provider/provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import '../../globals/globals_functions.dart';
import '../../globals/globals_sizes.dart';
import '../../globals/globlas_alert.dart';
import '../../globals/theme_controller.dart';
import '../../modals/modal_livro.dart';
import 'favorites_page_functions.dart';

class FavoriteWidget {
  FavoriteWidget(this.context);
  BuildContext context;

  Widget favoritePricipal(BuildContext contextAux) {
    final favoriteStore = Provider.of<FavoriteStore>(context);
    return Column(
      children: [
        Expanded(
          child: favoriteStore.listModelFavoriteMobX.isEmpty
              ? GlobalsWidgets(context).imgEmpty()
              : GridView.builder(
                  padding: EdgeInsets.all(GlobalsSizes().marginSize),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.5,
                  ),
                  itemCount: favoriteStore.listModelFavoriteMobX.length,
                  itemBuilder: (context, index) {
                    return _buildLivroCard(
                        favoriteStore.listModelFavoriteMobX[index], contextAux);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildLivroCard(LivrosModal livro, BuildContext contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final favoritePrincipalFunction =
        Provider.of<FavoritePrincipaFunctions>(context);

    return Observer(builder: (_) {
      livro.setIsDownloadOk(favoritePrincipalFunction.listDownloads
          .contains(livro.id.toString()));
      livro.setFavorite(
          favoritePrincipalFunction.listFavorite.contains(livro.id.toString()));
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
            await favoritePrincipalFunction.download(livro, context);

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
                        Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      GlobalsSizes().borderSize),
                                  topRight: Radius.circular(
                                      GlobalsSizes().borderSize),
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
                          ],
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
                                    favoritePrincipalFunction.listFavorite
                                        .remove(livro.id.toString());
                                    await GlobalsLocalStorage().setFavorite(
                                        listFavorite: favoritePrincipalFunction
                                            .listFavorite);
                                  } else {
                                    livro.setFavorite(true);
                                    favoritePrincipalFunction.listFavorite
                                        .add(livro.id.toString());
                                    await GlobalsLocalStorage().setFavorite(
                                        listFavorite: favoritePrincipalFunction
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
