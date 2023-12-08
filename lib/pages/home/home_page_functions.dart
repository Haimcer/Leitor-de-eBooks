import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:leitor_ebooks/request/livros/getAllLivros.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../globals/store/globals_store.dart';
import '../../modals/modal_livro.dart';

class HomePrincipalFunctions {
  BuildContext context;
  HomePrincipalFunctions(this.context);

  late HomeStore homeStoreAux;
  late GlobalsStore globalsStoreAux;
  bool loading = false;
  Dio dio = Dio();
  String filePath = "";
  List<String> listDownloads = [];
  List<String> listFavorite = [];

  Future homeFunctionPrincipal(
      GlobalsStore globalsStore, HomeStore homeStore) async {
    listFavorite.clear();
    listDownloads.clear();
    await _loadDownloadsAndFavorites();

    globalsStoreAux = globalsStore;
    homeStoreAux = homeStore;

    if (homeStore.listModelMobX.isEmpty) {
      await _fetchLivros(homeStore);
    }
  }

  Future<void> _loadDownloadsAndFavorites() async {
    final response = await GlobalsLocalStorage().getDownloads();
    final favorite = await GlobalsLocalStorage().getFavorite();
    listFavorite.addAll(favorite ?? []);
    listDownloads.addAll(response ?? []);
  }

  Future<void> _fetchLivros(HomeStore homeStore) async {
    try {
      var result = await GetAllLivros().getLivros(context);
      if (result != null) {
        result.forEach((value) {
          homeStore.setListModelMobX(LivrosModal.fromJson(value));
        });
      }
    } catch (e) {
      print("Erro ao buscar livros: $e");
    }
  }

  /// ANDROID VERSION
  Future<void> fetchAndroidVersion(
      LivrosModal? livro, BuildContext contextAux) async {
    final String? version = await getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.toString().contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        await startDownload(livro, contextAux);
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await startDownload(livro, contextAux);
        } else {
          await Permission.storage.request();
        }
      }
    }
  }

  Future<String?> getAndroidVersion() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    } catch (e) {
      print("Erro ao obter informações: $e");
    }
    return null;
  }

  Future<void> startDownload(
      LivrosModal? livro, BuildContext contextAux) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    String path = appDocDir!.path + '/${livro?.id}' + '.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      try {
        await dio
            .download(
          livro?.downloadUrl ?? '',
          path,
          deleteOnError: true,
          onReceiveProgress: (receivedBytes, totalBytes) {},
        )
            .then((_) async {
          listDownloads.add(livro?.id.toString() ?? '');
          await GlobalsLocalStorage()
              .setDawmloads(listDownloads: listDownloads);
          livro?.setLocalDirectory(path);
          livro?.setIsDownloadOk(true);
        }).catchError((error) {
          GlobalsAlert(contextAux).alertError(contextAux);
          livro?.setLoading(false);
        }).timeout(const Duration(seconds: 30), onTimeout: () {
          GlobalsAlert(contextAux).alertError(contextAux);
          livro?.setLoading(false);
        });
      } catch (e) {
        GlobalsAlert(contextAux).alertError(contextAux);
      }
    } else {
      livro?.setLocalDirectory(path);
    }
    livro?.setLoading(false);
  }

  download(LivrosModal livro, BuildContext contextAux) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload(livro, contextAux);
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await fetchAndroidVersion(livro, contextAux);
    } else {
      PlatformException(code: '500');
    }
  }
}
