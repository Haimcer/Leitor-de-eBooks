import 'package:flutter/material.dart';
import 'package:leitor_ebooks/request/livros/getAllLivros.dart';

import '../../modals/modal_livro.dart';

class HomePrincipalFunctions {
  BuildContext context;
  HomePrincipalFunctions(this.context);

  List<LivrosModal> fichasListModel = [];

  Future homeFunctionPrincipal() async {
    try {
      var result = await GetAllLivros().getLivros(context);
      if (result != null) {
        await result.forEach((value) {
          fichasListModel.add(LivrosModal.fromJson(value));
        });
      }
    } catch (e) {}
  }
}
