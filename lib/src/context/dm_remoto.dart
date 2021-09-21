import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/model/categoria_model.dart';
import 'package:vendas_app/src/model/cliente_model.dart';
import 'package:vendas_app/src/model/produto_model.dart';

//metodo para ler as categorias do dw
Future<List<CategoriasModel>> buscaCategorias(String url) async {
  //limpar a tabela categoria
  await Context.instance.delCategoria();

  final resposta = await http.get(Uri.parse(url));

  if (resposta.statusCode == 200) {
    List _categorias = json.decode(utf8.decode(resposta.bodyBytes));
    print(_categorias.toList());
    return _categorias
        .map((_categorias) => CategoriasModel.fromJson(_categorias))
        .toList();
  } else
    throw Exception('Erro ao carregar categorias');
}

//metodo para ler as produtos do dw
Future<List<ProdutosModel>> buscaProdutos(String url) async {
  //limpar a tabela produtos
  await Context.instance.delProduto();

  final resposta = await http.get(Uri.parse(url));

  if (resposta.statusCode == 200) {
    List _produtos = json.decode(utf8.decode(resposta.bodyBytes));
    print(_produtos.toList());
    return _produtos
        .map((_produtos) => ProdutosModel.fromJson(_produtos))
        .toList();
  } else
    throw Exception('Erro ao carregar produtos');
}

//metodo para ler as clientes do dw
Future<List<ClientesModel>> buscaClientes(String url) async {
  //limpar a tabela produtos
  await Context.instance.delCliente();

  final resposta = await http.get(Uri.parse(url));

  if (resposta.statusCode == 200) {
    List _clientes = json.decode(utf8.decode(resposta.bodyBytes));
    print(_clientes.toList());
    return _clientes
        .map((_clientes) => ClientesModel.fromJson(_clientes))
        .toList();
  } else
    throw Exception('Erro ao carregar produtos');
}

Future<void> enviaPedido(String url) async {
  List _ped = await Context.instance.enviarPedido();
  List _itens = await Context.instance.enviarItens();

  if (_ped.length > 0) {
    String _jHeader = json.encode(_ped);
    var hEncodado = utf8.encode(_jHeader);
    var h = base64.encode(hEncodado);

    String _jItens = json.encode(_itens);
    var iEncodado = utf8.encode(_jItens);
    var i = base64.encode(iEncodado);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {"pHeader": h, "pItens": i},
    );

    if (response.statusCode == 200) {
      if (response.body == '{"MESSAGE":"OK",  "RESULT":"OK"}') {
        Context.instance.delAllPedidos();
        Context.instance.delAllItem();
      }
    }
  }
  return null;
  // print(_ped);
  // print('------------------------');
  // print(_itens);
}

Future<void> listaCategoria() async {
  Stream<List<Categoria>> _ped = Context.instance.enviaCat();
  print(_ped);
}

Future<void> enviarClientes(String url) async {
  List _cli = await Context.instance.enviaCliente();
  print(_cli);
  if (_cli.length > 0) {
    String _jsonc = json.encode(_cli);
    var cEncodado = utf8.encode(_jsonc);
    var c = base64.encode(cEncodado);

    final response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {"pSelect": c});

    if (response.statusCode == 200) {
      if (response.body == 'ok') {
        print(response.body);
        Context.instance.zeraCliente();
      }
    }
  }
}
