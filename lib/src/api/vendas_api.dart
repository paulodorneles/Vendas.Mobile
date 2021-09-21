import 'package:pedidos/src/model/pedido_entity.dart';
import 'package:pedidos/src/shared/constantes.dart';
import 'dart:convert';
//import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:async';
import 'dart:io';

class VendasApi {
  static Future postVendas(PedidoEntity pedido) async {
    var url = Constantes.url + "/Vendas";
    var body = json.encode(pedido.toJson());

    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = new IOClient(ioc);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }
}
