// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$filepathAtom =
      Atom(name: '_HomeStore.filepath', context: context);

  @override
  String get filepath {
    _$filepathAtom.reportRead();
    return super.filepath;
  }

  @override
  set filepath(String value) {
    _$filepathAtom.reportWrite(value, super.filepath, () {
      super.filepath = value;
    });
  }

  late final _$progressAtom =
      Atom(name: '_HomeStore.progress', context: context);

  @override
  double get progress {
    _$progressAtom.reportRead();
    return super.progress;
  }

  @override
  set progress(double value) {
    _$progressAtom.reportWrite(value, super.progress, () {
      super.progress = value;
    });
  }

  late final _$listModelMobXAtom =
      Atom(name: '_HomeStore.listModelMobX', context: context);

  @override
  ObservableList<LivrosModal> get listModelMobX {
    _$listModelMobXAtom.reportRead();
    return super.listModelMobX;
  }

  @override
  set listModelMobX(ObservableList<LivrosModal> value) {
    _$listModelMobXAtom.reportWrite(value, super.listModelMobX, () {
      super.listModelMobX = value;
    });
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setFilePath(String newPath) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setFilePath');
    try {
      return super.setFilePath(newPath);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAllListMobX(List<LivrosModal> list) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setAllListMobX');
    try {
      return super.setAllListMobX(list);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void listReload() {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.listReload');
    try {
      return super.listReload();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListModelMobX(LivrosModal ficha) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setListModelMobX');
    try {
      return super.setListModelMobX(ficha);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListModelMobXClear() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setListModelMobXClear');
    try {
      return super.setListModelMobXClear();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProgress(double value) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.setProgress');
    try {
      return super.setProgress(value);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filepath: ${filepath},
progress: ${progress},
listModelMobX: ${listModelMobX}
    ''';
  }
}
