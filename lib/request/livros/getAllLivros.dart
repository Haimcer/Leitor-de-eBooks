import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../globals/globlas_alert.dart';

class GetAllLivros {
  Future getLivros(BuildContext contextAux) async {
    try {
      final returnData = await http.get(
        Uri.parse("https://escribo.com/books.json"),
      );

      if (returnData.statusCode >= 200 && returnData.statusCode < 206) {
        var dataReturn = await json.decode(returnData.body);
        return dataReturn;
      }

      if (returnData.statusCode == 404) {
        GlobalsAlert(contextAux).alertWarning(contextAux,
            text:
                "Ops! não encontramos o que você está procurando, por favor verifique sua conexão com a internet !");
        return null;
      }
    } catch (error) {
      GlobalsAlert(contextAux).alertError(contextAux,
          text:
              "Ops! Tivemos um problema desconhecido, não se preocupe estamos trabalhando para resolver !");
    }
    GlobalsAlert(contextAux).alertError(contextAux,
        text: "Ops! Tivemos um problema interno por favor, tente mais tarde !");

    return null;
  }
}
