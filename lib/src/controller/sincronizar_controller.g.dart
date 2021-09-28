// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sincronizar_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SincronizarController on _SincronizarController, Store {
  final _$statusClienteAtom =
      Atom(name: '_SincronizarController.statusCliente');

  @override
  String get statusCliente {
    _$statusClienteAtom.reportRead();
    return super.statusCliente;
  }

  @override
  set statusCliente(String value) {
    _$statusClienteAtom.reportWrite(value, super.statusCliente, () {
      super.statusCliente = value;
    });
  }

  final _$statusCondPgtoAtom =
      Atom(name: '_SincronizarController.statusCondPgto');

  @override
  String get statusCondPgto {
    _$statusCondPgtoAtom.reportRead();
    return super.statusCondPgto;
  }

  @override
  set statusCondPgto(String value) {
    _$statusCondPgtoAtom.reportWrite(value, super.statusCondPgto, () {
      super.statusCondPgto = value;
    });
  }

  final _$statusProdutoAtom =
      Atom(name: '_SincronizarController.statusProduto');

  @override
  String get statusProduto {
    _$statusProdutoAtom.reportRead();
    return super.statusProduto;
  }

  @override
  set statusProduto(String value) {
    _$statusProdutoAtom.reportWrite(value, super.statusProduto, () {
      super.statusProduto = value;
    });
  }

  final _$statusVendaAtom = Atom(name: '_SincronizarController.statusVenda');

  @override
  String get statusVenda {
    _$statusVendaAtom.reportRead();
    return super.statusVenda;
  }

  @override
  set statusVenda(String value) {
    _$statusVendaAtom.reportWrite(value, super.statusVenda, () {
      super.statusVenda = value;
    });
  }

  final _$_SincronizarControllerActionController =
      ActionController(name: '_SincronizarController');

  @override
  void setStatusCliente(String value) {
    final _$actionInfo = _$_SincronizarControllerActionController.startAction(
        name: '_SincronizarController.setStatusCliente');
    try {
      return super.setStatusCliente(value);
    } finally {
      _$_SincronizarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatusProduto(String value) {
    final _$actionInfo = _$_SincronizarControllerActionController.startAction(
        name: '_SincronizarController.setStatusProduto');
    try {
      return super.setStatusProduto(value);
    } finally {
      _$_SincronizarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatusCondPagto(String value) {
    final _$actionInfo = _$_SincronizarControllerActionController.startAction(
        name: '_SincronizarController.setStatusCondPagto');
    try {
      return super.setStatusCondPagto(value);
    } finally {
      _$_SincronizarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatusVendas(String value) {
    final _$actionInfo = _$_SincronizarControllerActionController.startAction(
        name: '_SincronizarController.setStatusVendas');
    try {
      return super.setStatusVendas(value);
    } finally {
      _$_SincronizarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarCliente() {
    final _$actionInfo = _$_SincronizarControllerActionController.startAction(
        name: '_SincronizarController.buscarCliente');
    try {
      return super.buscarCliente();
    } finally {
      _$_SincronizarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buscarProduto() {
    final _$actionInfo = _$_SincronizarControllerActionController.startAction(
        name: '_SincronizarController.buscarProduto');
    try {
      return super.buscarProduto();
    } finally {
      _$_SincronizarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
statusCliente: ${statusCliente},
statusCondPgto: ${statusCondPgto},
statusProduto: ${statusProduto},
statusVenda: ${statusVenda}
    ''';
  }
}
