import 'package:http/io_client.dart';
import 'package:pedidos/src/shared/constantes.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class UsuarioApi {
  static Future postUsuario(String login, String senha, String emp) async {
    var url = Constantes.url + "/Login";
    Map data = {'email': login, 'senha': senha, 'emp': ''};
    var body = json.encode(data);

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }
}
