import 'package:connectivity_plus/connectivity_plus.dart';

class GlobalsFunctions {
  ///Verifica conexão com a internet
  Future<bool> verificaConexao() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
