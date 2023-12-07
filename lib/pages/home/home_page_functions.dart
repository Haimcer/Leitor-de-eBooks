import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future homeFunctionPrincipal(
      GlobalsStore globalsStore, HomeStore homeStore) async {
    homeStore.setListModelMobXClear();
    globalsStoreAux = globalsStore;
    homeStoreAux = homeStore;
    try {
      var result = await GetAllLivros().getLivros(context);
      if (result != null) {
        await result.forEach((value) {
          homeStore.setListModelMobX(LivrosModal.fromJson(value));
        });
      }
    } catch (e) {}
  }

  /// ANDROID VERSION
  Future<void> fetchAndroidVersion(LivrosModal? livro) async {
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
        await startDownload(livro ?? LivrosModal());
      } else {
        final PermissionStatus status = await Permission.storage.request();
        if (status == PermissionStatus.granted) {
          await startDownload(livro ?? LivrosModal());
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

  Future<void> startDownload([LivrosModal? livro]) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    String path = appDocDir!.path + '/${livro?.id}' + '.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        livro?.downloadUrl ?? '',
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          globalsStoreAux.setLoading(true);
          double progress = receivedBytes / totalBytes;
          homeStoreAux.setProgress(progress);
          print(progress);
        },
      ).whenComplete(() {
        homeStoreAux.setFilePath(path);
        globalsStoreAux.setLoading(false);
      });
    } else {
      homeStoreAux.setFilePath(path);
      globalsStoreAux.setLoading(false);
    }
  }

  download(LivrosModal livro) async {
    if (Platform.isIOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload(livro);
      } else {
        await Permission.storage.request();
      }
    } else if (Platform.isAndroid) {
      await fetchAndroidVersion(livro);
    } else {
      PlatformException(code: '500');
    }
  }
}
