import 'package:mobx/mobx.dart';

part 'modal_livro.g.dart';

class LivrosModal = _LivrosModalBase with _$LivrosModal;

abstract class _LivrosModalBase with Store {
  @observable
  int? id;

  @observable
  String? title;

  @observable
  String? author;

  @observable
  String? coverUrl;

  @observable
  String? downloadUrl;

  @observable
  bool? favorite;

  @observable
  bool? loading;

  @observable
  String? localDirectory;

  @observable
  bool? isDownloadOk;

  _LivrosModalBase(
      {this.id,
      this.title,
      this.author,
      this.coverUrl,
      this.downloadUrl,
      this.favorite,
      this.loading,
      this.isDownloadOk});

  _LivrosModalBase.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }

  @action
  void setId(int? value) {
    id = value;
  }

  @action
  void setTitle(String? value) {
    title = value;
  }

  @action
  void setAuthor(String? value) {
    author = value;
  }

  @action
  void setCoverUrl(String? value) {
    coverUrl = value;
  }

  @action
  void setDownloadUrl(String? value) {
    downloadUrl = value;
  }

  @action
  void setFavorite(bool? value) {
    favorite = value;
  }

  @action
  void setLoading(bool? value) {
    loading = value;
  }

  @action
  void setLocalDirectory(String? value) {
    localDirectory = value;
  }

  @action
  void setIsDownloadOk(bool? value) {
    isDownloadOk = value;
  }
}
