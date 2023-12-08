// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoriteStore on _FavoriteStore, Store {
  late final _$listModelFavoriteMobXAtom =
      Atom(name: '_FavoriteStore.listModelFavoriteMobX', context: context);

  @override
  ObservableList<LivrosModal> get listModelFavoriteMobX {
    _$listModelFavoriteMobXAtom.reportRead();
    return super.listModelFavoriteMobX;
  }

  @override
  set listModelFavoriteMobX(ObservableList<LivrosModal> value) {
    _$listModelFavoriteMobXAtom.reportWrite(value, super.listModelFavoriteMobX,
        () {
      super.listModelFavoriteMobX = value;
    });
  }

  late final _$_FavoriteStoreActionController =
      ActionController(name: '_FavoriteStore', context: context);

  @override
  void setAllListFavoriteMobX(List<LivrosModal> list) {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction(
        name: '_FavoriteStore.setAllListFavoriteMobX');
    try {
      return super.setAllListFavoriteMobX(list);
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReload() {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction(
        name: '_FavoriteStore.listReload');
    try {
      return super.listReload();
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListModelFavoriteMobX(LivrosModal ficha) {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction(
        name: '_FavoriteStore.setListModelFavoriteMobX');
    try {
      return super.setListModelFavoriteMobX(ficha);
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListModelFavoriteMobXClear() {
    final _$actionInfo = _$_FavoriteStoreActionController.startAction(
        name: '_FavoriteStore.setListModelFavoriteMobXClear');
    try {
      return super.setListModelFavoriteMobXClear();
    } finally {
      _$_FavoriteStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listModelFavoriteMobX: ${listModelFavoriteMobX}
    ''';
  }
}
