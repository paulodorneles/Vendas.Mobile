import 'package:money2/money2.dart';
import 'package:jiffy/jiffy.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/app_controller.dart';

part 'vendas_controller.g.dart';

class VendasController = _VendasController with _$VendasController;

abstract class _VendasController with Store {
  var controller = new AppController();
  double totalPedido = 0;
  String pedidoCodigo = '';

  @observable
  String pedidoTotal = 'R\$ 0,00';

  @action
  void updPedidoTotal(String value) {
    pedidoTotal = value;
  }

  @action
  salvarItem(int qtde, final prod) {
    double _sTotal = qtde * prod.preco;
    String _totalFormatado;
    double _sTotalFormatado = 0;

    _sTotal < double.tryParse('10')
        ? _sTotalFormatado = double.parse(_sTotal.toStringAsPrecision(3))
        : _sTotalFormatado = double.parse(_sTotal.toStringAsPrecision(4));

    /*  _sTotal < double.tryParse('10')
        ? _totalFormatado = 'R\$ ' +
            _sTotal.toStringAsPrecision(3)
        : _totalFormatado = 'R\$ ' +
            _sTotal
                .toStringAsPrecision(4); */
    print(_totalFormatado);

    Context.instance.updProduto(
      Produto(
        id: prod.id,
        idcategoria: prod.idcategoria,
        unidade: prod.unidade,
        preco: prod.preco,
        nome: prod.nome,
        quant: qtde,
        //valorfmt: prod.valorfmt,
        total: _sTotalFormatado,
      ),
    );

    var total = Context.instance.subtotalVenda();

    totalPedido = total ?? 0;

    //controller.updpedidototal(_ts);

    Currency ptBr = Currency.create('BRL', 2, symbol: 'R\$ ');
    String _totalGeralFmt = Money.from(totalPedido, ptBr).toString();

    updPedidoTotal(_totalGeralFmt);
    print(_totalGeralFmt);
  }

  Future salvarPedido(String nomeCli, String codCli) async {
    if (totalPedido > 0) {
      await Context.instance.addPedido(
        Pedido(
            id: gerarCodigoPedido(),
            idvendedor: controller.idUsuario,
            idcliente: codCli,
            nomecliente: nomeCli,
            datapedido: Jiffy().format('dd[/]MM[/]yyyy'),
            total: totalPedido,
            //totalfmt: controller.pedidoSubtotal,
            enviado: 0),
      );
      await Context.instance.gravaItens(controller.pedidoCodigo);
      await Context.instance.zeraProduto();

      // controller.updpedidototal(0);
    }
  }

  String gerarCodigoPedido() {
    return pedidoCodigo = controller.idUsuario.toString() +
        '1' +
        DateTime.now().millisecondsSinceEpoch.toString();
  }
}
