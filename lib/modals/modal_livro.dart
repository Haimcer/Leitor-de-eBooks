class LivrosModal {
  int? id;
  String? title;
  String? author;
  String? coverUrl;
  String? downloadUrl;
  bool? favorite;
  bool? loading;

  LivrosModal({
    this.id,
    this.title,
    this.author,
    this.coverUrl,
    this.downloadUrl,
    this.favorite,
    this.loading,
  });

  LivrosModal.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];
  }
}
