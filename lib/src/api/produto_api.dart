//import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:vendas_app/src/shared/constantes.dart';
import 'dart:io';

class ProdutoApi {
  static getProdutos() async {
    var url = Constantes.url + "/Produto/Listar";
    //return await http.get(url);
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return await http
        .get(Uri.parse(url), headers: {"Accept": "application/json"});
  }
}
