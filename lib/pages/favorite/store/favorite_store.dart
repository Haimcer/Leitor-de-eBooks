import 'package:mobx/mobx.dart';

import '../../../modals/modal_livro.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  @observable
  String filepath = '';

  @observable
  ObservableList<LivrosModal> listModelFavoriteMobX =
      ObservableList<LivrosModal>();

  @action
  void setFilePath(String newPath) {
    print('entrou aqui');
    filepath = newPath;
  }

  @action
  void setAllListFavoriteMobX(List<LivrosModal> list) {
    listModelFavoriteMobX.clear();
    listModelFavoriteMobX.addAll(list);
  }

  @action
  void listReload() {
    final list = List<LivrosModal>.from(listModelFavoriteMobX);
    listModelFavoriteMobX.clear();
    setAllListFavoriteMobX(list);
  }

  @action
  void setListModelFavoriteMobX(LivrosModal ficha) {
    listModelFavoriteMobX.add(ficha);
  }

  @action
  void setListModelFavoriteMobXClear() {
    listModelFavoriteMobX.clear();
  }
}
