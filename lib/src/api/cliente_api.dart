import 'package:http/http.dart' as http;
import 'package:vendas_app/src/shared/constantes.dart';

class ClienteApi {
  static getClientes(String pCodVendedor) async {
    String url = Constantes.url + "/Cliente/Listar";
    return http.get(Uri.parse(url), headers: {"Accept": "application/json"});
  }
}
