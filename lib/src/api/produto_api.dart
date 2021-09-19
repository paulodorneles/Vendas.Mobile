import 'package:http/http.dart' as http;
import 'package:vendas_app/src/shared/constantes.dart';

class ProdutoApi {
  static getProdutos() async {
    var url = Constantes.url + "/Produto/Listar";    
    return await http
        .get(Uri.parse(url), headers: {"Accept": "application/json"});
  }
}
