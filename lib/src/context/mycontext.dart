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
  @override
  Set<Column> get primaryKey => {id};
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

  @override
  int get schemaVersion => 1;
}