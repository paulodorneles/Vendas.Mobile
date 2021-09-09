import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'mycontext.g.dart';

class Categorias extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get nome => text().withLength(max: 30)();
}

class Produtos extends Table {
  IntColumn get id => integer()();
  TextColumn get nome => text().withLength(max: 50)();
  IntColumn get idcategoria => integer()();
  TextColumn get unidade => text()();
  IntColumn get preco => integer()();
  TextColumn get valorfmt => text()();
  TextColumn get total => text()();
  // RealColumn get quant => real()();
  IntColumn get quant => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

class Clientes extends Table {
  TextColumn get id => text()();
  TextColumn get cnpj => text()();
  TextColumn get nome => text().withLength(max: 50)();
  TextColumn get fantasia => text().withLength(max: 50)();
  TextColumn get endereco => text()();
  TextColumn get numero => text()();
  TextColumn get bairro => text()();
  TextColumn get cep => text()();
  TextColumn get telefone => text()();
  TextColumn get uf => text()();
  TextColumn get municipio => text()();
  TextColumn get lat => text()();
  TextColumn get lng => text()();
  IntColumn get alterado => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
}

class Pedidos extends Table {
  TextColumn get id => text()();
  IntColumn get idvendedor => integer()();
  TextColumn get idcliente => text()();
  TextColumn get nomecliente => text()();
  TextColumn get datapedido => text()();
  IntColumn get total => integer()();
  TextColumn get totalfmt => text()();
  IntColumn get enviado => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
}

class Itens extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idpedido => text()();
  IntColumn get idproduto => integer()();
  IntColumn get qtde => integer()();
  IntColumn get valor => integer()();
  TextColumn get totalfmt => text()();
  TextColumn get nome => text().withLength(max: 50)();
  IntColumn get enviado => integer().withDefault(const Constant(0))();
 
}

@UseMoor(
  tables: [
    Categorias,
    Produtos,
    Clientes,
    Pedidos,
    Itens,
  ],
  queries: {
    'contaCategorias': 'SELECT COUNT(*) FROM categorias AS "TOTAL";',
    'contaProdutos': 'SELECT COUNT(*) FROM produtos AS "TOTAL";',
    'contaClientes': 'SELECT COUNT(*) FROM clientes AS "TOTAL";',
    'contaPedidosAll': 'SELECT COUNT(*) FROM pedidos AS "TOTAL";',
    'contaPedidosEnviado':
        'SELECT COUNT(*) FROM pedidos AS "TOTAL" WHERE enviado = 1;',
    'contaPedidosLocal':
        'SELECT COUNT(*) FROM pedidos AS "TOTAL" WHERE enviado = 0;',
  },
)

class Context extends _$Context {
  static final Context instance = Context._internal();

  //criar um singleton
  Context._internal()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  //categoria
  Stream<List<Categoria>> getCategoria() {
    return select(categorias).watch();
  }

  Future addCategoria(Categoria categoria) {
    return into(categorias).insert(categoria);
  }

  Future delCategoria() {
    return (delete(categorias)).go();
  }

  //produtos
  Future addProduto(Produto produto) {
    return into(produtos).insert(produto);
  }

  Future delProduto() {
    return (delete(produtos)).go();
  }

  Future updProduto(Produto prod) {
    return (update(produtos)).replace(prod);
  }

  Future zeraProduto() {
    return customSelectQuery('Update Produtos set quant = 0 where quant > 0')
        .get();
  }

  Future addPedido(Pedido ped) {
    return into(pedidos).insert(ped);
  }

  Future gravaItens(String idPed) {
    return customSelectQuery('INSERT INTO Itens (idpedido, idproduto, qtde,' +
            ' totalfmt, nome, enviado)' +
            'select "$idPed", id, quant, valorfmt, nome, 0 from produtos where quant > 0')
        .get();
  }

  /*
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idpedido => text()();
  IntColumn get idproduto => integer()();
  IntColumn get qtde => integer()();
  //IntColumn get valor => integer()();
  TextColumn get totalfmt => text()();
  TextColumn get nome => text().withLength(max: 50)();
  IntColumn get enviado => integer().withDefault(const Constant(0))();
   */

  subtotalVenda() {
    return customSelectQuery(
            'select SUM(preco * quant) as total from produtos where quant > 0')
        .getSingle()
        .then((row) => row.data["total"]);
  }

  Stream<List<Produto>> getProduto(String nomeProd) {
    if (nomeProd == null || nomeProd.isEmpty)
      return (select(produtos)
            ..orderBy(
              ([
                (p) => OrderingTerm(expression: p.nome, mode: OrderingMode.asc),
              ]),
            ))
          .watch();
    else
      return (select(produtos)
            ..where((produto) =>
                produto.nome.upper().like('%' + nomeProd.toUpperCase() + '%'))
            ..orderBy(
              ([
                (p) => OrderingTerm(
                    expression: produtos.nome, mode: OrderingMode.asc),
              ]),
            ))
          .watch();
  }

  //filtrar produtos pela categoria
  Stream<List<Produto>> getProdutosCategoria(int id) {
    return (select(produtos)
          ..where((produto) => produto.idcategoria.equals(id)))
        .watch();
  }

  Future delAllPedidos() {
    return (delete(pedidos).go());
  }

  Future delPedidoId(String idPedido) {
    return (delete(pedidos)..where((id) => pedidos.id.equals(idPedido))).go();
  }

  Stream<List<Pedido>> getPedidos() {
    return (select(pedidos)
          ..orderBy(
            ([(p) => OrderingTerm(expression: p.id, mode: OrderingMode.asc)]),
          ))
        .watch();
  }

  //itens
  Future addItem(Iten item) {
    return into(itens).insert(item);
  }

  Future delAllItem() {
    return (delete(itens)).go();
  }

  Future delItemId(int idItem) {
    return (delete(itens)..where((id) => itens.id.equals(idItem))).go();
  }

  Future delItensPedido(String idPed) {
    return customSelectQuery('delete from itens where idpedido = "$idPed"')
        .get();
  }

//clientes
  Future addCliente(Cliente cliente) {
    return into(clientes).insert(cliente);
  }

  Future delCliente() {
    return (delete(clientes)).go();
  }

  Stream<List<Cliente>> getCliente(String nomeCli) {
    if (nomeCli == null || nomeCli.isEmpty)
      return (select(clientes)
            ..orderBy(
              ([
                (c) => OrderingTerm(expression: c.nome, mode: OrderingMode.asc),
              ]),
            ))
          .watch();
    else
      return (select(clientes)
            ..where((cliente) =>
                cliente.nome.upper().like('%' + nomeCli.toUpperCase() + '%'))
            ..orderBy(
              ([
                (c) => OrderingTerm(expression: c.nome, mode: OrderingMode.asc),
              ]),
            ))
          .watch();
  }

  Future<List<Cliente>> enviaCliente() {
    return (select(clientes)..where((cliente) => cliente.alterado.equals(1)))
        .get();
  }

  Future zeraCliente() {
    return customSelectQuery('Update Clientes set alterado = 0').get();
  }

  Future<List<Pedido>> getPedidoLocal() {
    return (select(pedidos)..where((pedido) => pedido.enviado.equals(0))).get();
  }

  Future<List<Iten>> getItensLocal() {
    return (select(itens)..where((iten) => iten.enviado.equals(0))).get();
  }
  //selects para envio

  Future<List<Iten>> enviarItens() {
    return (select(itens)
          ..addColumns([itens.idpedido, itens.idproduto, itens.qtde])
          ..where((iten) => iten.enviado.equals(0)))
        .get();
  }

  Future<List<Pedido>> enviarPedido() {
    return (select(pedidos)..where((pedido) => pedido.enviado.equals(0))).get();
  }

  Stream<List<Categoria>> enviaCat() {
    return (select(categorias)).watch().map((rows) => rows.map((row) {
          return Categoria(nome: row.nome);
          //ticket: row.readTable( userTicket.map((data)=>) ));
        }).toList());
  }

  Future alteraLocation(int codigo, String lat, lng) {
    return customSelectQuery(
            'Update Clientes SET lat = $lat, lng = $lng where id = $codigo')
        .get();
  }

  Future updCliente(Cliente cli) {
    return (update(clientes)).replace(cli);
  }

  //contar rows
  Future<int> countCa() async => (await select(categorias).get()).length;
  Future<int> countPr() async => (await select(produtos).get()).length;
  Future<int> countPe() async => (await select(pedidos).get()).length;
  Future<int> countCl() async => (await select(clientes).get()).length;

  String id = '';
  String nome = '';
  String cnpj = '';
  String bairro = '';
  String cep = '';
  String endereco = '';
  String fantasia = '';
  String lat = '';
  String lng = '';
  String municipio = '';
  String numero = '';
  String telefone = '';
  String uf = '';
  String alterado = '';

  @override
  int get schemaVersion => 1;
}