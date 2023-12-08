// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modal_livro.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LivrosModal on _LivrosModalBase, Store {
  late final _$idAtom = Atom(name: '_LivrosModalBase.id', context: context);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$titleAtom =
      Atom(name: '_LivrosModalBase.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$authorAtom =
      Atom(name: '_LivrosModalBase.author', context: context);

  @override
  String? get author {
    _$authorAtom.reportRead();
    return super.author;
  }

  @override
  set author(String? value) {
    _$authorAtom.reportWrite(value, super.author, () {
      super.author = value;
    });
  }

  late final _$coverUrlAtom =
      Atom(name: '_LivrosModalBase.coverUrl', context: context);

  @override
  String? get coverUrl {
    _$coverUrlAtom.reportRead();
    return super.coverUrl;
  }

  @override
  set coverUrl(String? value) {
    _$coverUrlAtom.reportWrite(value, super.coverUrl, () {
      super.coverUrl = value;
    });
  }

  late final _$downloadUrlAtom =
      Atom(name: '_LivrosModalBase.downloadUrl', context: context);

  @override
  String? get downloadUrl {
    _$downloadUrlAtom.reportRead();
    return super.downloadUrl;
  }

  @override
  set downloadUrl(String? value) {
    _$downloadUrlAtom.reportWrite(value, super.downloadUrl, () {
      super.downloadUrl = value;
    });
  }

  late final _$favoriteAtom =
      Atom(name: '_LivrosModalBase.favorite', context: context);

  @override
  bool? get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool? value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_LivrosModalBase.loading', context: context);

  @override
  bool? get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool? value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$localDirectoryAtom =
      Atom(name: '_LivrosModalBase.localDirectory', context: context);

  @override
  String? get localDirectory {
    _$localDirectoryAtom.reportRead();
    return super.localDirectory;
  }

  @override
  set localDirectory(String? value) {
    _$localDirectoryAtom.reportWrite(value, super.localDirectory, () {
      super.localDirectory = value;
    });
  }

  late final _$isDownloadOkAtom =
      Atom(name: '_LivrosModalBase.isDownloadOk', context: context);

  @override
  bool? get isDownloadOk {
    _$isDownloadOkAtom.reportRead();
    return super.isDownloadOk;
  }

  @override
  set isDownloadOk(bool? value) {
    _$isDownloadOkAtom.reportWrite(value, super.isDownloadOk, () {
      super.isDownloadOk = value;
    });
  }

  late final _$_LivrosModalBaseActionController =
      ActionController(name: '_LivrosModalBase', context: context);

  @override
  void setId(int? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setId');
    try {
      return super.setId(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTitle(String? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setTitle');
    try {
      return super.setTitle(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAuthor(String? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setAuthor');
    try {
      return super.setAuthor(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCoverUrl(String? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setCoverUrl');
    try {
      return super.setCoverUrl(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDownloadUrl(String? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setDownloadUrl');
    try {
      return super.setDownloadUrl(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFavorite(bool? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setFavorite');
    try {
      return super.setFavorite(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocalDirectory(String? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setLocalDirectory');
    try {
      return super.setLocalDirectory(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsDownloadOk(bool? value) {
    final _$actionInfo = _$_LivrosModalBaseActionController.startAction(
        name: '_LivrosModalBase.setIsDownloadOk');
    try {
      return super.setIsDownloadOk(value);
    } finally {
      _$_LivrosModalBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
title: ${title},
author: ${author},
coverUrl: ${coverUrl},
downloadUrl: ${downloadUrl},
favorite: ${favorite},
loading: ${loading},
localDirectory: ${localDirectory},
isDownloadOk: ${isDownloadOk}
    ''';
  }
}
