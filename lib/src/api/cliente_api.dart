import 'package:http/io_client.dart';
import 'package:vendas_app/src/shared/constantes.dart';
import 'dart:io';

class ClienteApi {
  static getClientes() async {
    String url = Constantes.url + "Cliente/Listar";
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  }
}
