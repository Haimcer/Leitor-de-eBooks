import 'package:mobx/mobx.dart';

import '../../../modals/modal_livro.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  ObservableList<LivrosModal> listModelMobX = ObservableList<LivrosModal>();

  @action
  void setAllListMobX(List<LivrosModal> list) {
    listModelMobX.clear();
    listModelMobX.addAll(list);
  }

  @action
  void listReload() {
    final list = List<LivrosModal>.from(listModelMobX);
    listModelMobX.clear();
    setAllListMobX(list);
  }

  @action
  void setListModelMobX(LivrosModal ficha) {
    listModelMobX.add(ficha);
  }

  @action
  void setListModelMobXClear() {
    listModelMobX.clear();
  }
}
