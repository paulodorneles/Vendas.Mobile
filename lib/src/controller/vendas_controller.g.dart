// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendas_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VendasController on _VendasController, Store {
  final _$pedidoTotalAtom = Atom(name: '_VendasController.pedidoTotal');

  @override
  String get pedidoTotal {
    _$pedidoTotalAtom.reportRead();
    return super.pedidoTotal;
  }

  @override
  set pedidoTotal(String value) {
    _$pedidoTotalAtom.reportWrite(value, super.pedidoTotal, () {
      super.pedidoTotal = value;
    });
  }

  final _$_VendasControllerActionController =
      ActionController(name: '_VendasController');

  @override
  void updPedidoTotal(String value) {
    final _$actionInfo = _$_VendasControllerActionController.startAction(
        name: '_VendasController.updPedidoTotal');
    try {
      return super.updPedidoTotal(value);
    } finally {
      _$_VendasControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic salvarItem(int qtde, dynamic prod) {
    final _$actionInfo = _$_VendasControllerActionController.startAction(
        name: '_VendasController.salvarItem');
    try {
      return super.salvarItem(qtde, prod);
    } finally {
      _$_VendasControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedidoTotal: ${pedidoTotal}
    ''';
  }
}
