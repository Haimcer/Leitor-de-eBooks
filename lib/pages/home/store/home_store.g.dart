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
  String toString() {
    return '''
filepath: ${filepath}
    ''';
  }
}
