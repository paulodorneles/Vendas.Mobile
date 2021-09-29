import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:money2/money2.dart';
import 'package:intl/intl.dart';
import 'package:vendas_app/src/shared/format.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/app_controller.dart';
import 'package:vendas_app/src/controller/vendas_controller.dart';

class PedProduto extends StatefulWidget {
  final nomeCli;
  final codigoCli;

  PedProduto({this.codigoCli, this.nomeCli});
  @override
  _PedProdutoState createState() => _PedProdutoState();
}

class _PedProdutoState extends State<PedProduto> {
  TextEditingController _nomeProd = TextEditingController();
  var controller = new AppController();
  var controllerPed = new VendasController();
  // controllerPed.nomeCli = widget.nomeCli;

  //String nomeCli = '';
  //String codigoCli = '';

  //controllerPed.nomeCli

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff46997D),
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 15,
              ),
              OutlineButton(
                onPressed: () async {
                  var _t = await Context.instance.subtotalVenda();
                  int _ts = _t ?? 0;
                  if (_ts > 0) {
                    await Context.instance.zeraProduto();
                  }
                  Navigator.pop(context);
                  //  Modular.to.popUntil(ModalRoute.withName('menu'));
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(),
              Observer(
                builder: (_) {
                  return Text(
                    controllerPed.pedidoTotal,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                },
              ),
              Spacer(),
              OutlineButton(
                onPressed: () async {
                  controllerPed.salvarPedido(widget.nomeCli, widget.codigoCli);

                  int _totped = await Context.instance.countPe();
                  controller.updTotPed(_totped);
                  controller.gravarArqIni();
                  Navigator.pop(context);
                  //Modular.to.popUntil(ModalRoute.withName('menu'));
                },
                child: Text(
                  'Gravar',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 15),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nº do Pedido: ${controller.pedidoCodigo}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          controller.pNomeCliente,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff317183),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Data do registro:' +
                              Jiffy().format('dd[/]MM[/]yyyy [às] hh:mm'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Selecione os produtos do pedido',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff317183),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextField(
                  controller: _nomeProd,
                  onChanged: (value) async {
                    controller.updnomeProduto(value);
                  },
                  inputFormatters: [
                    UpperCaseTextFormatter(),
                  ],
                  style: TextStyle(
                    color: Color(0xff317183),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xff317183).withOpacity(0.2),
                    filled: true,
                    labelText: 'Localizar',
                    prefixIcon: Icon(
                      FontAwesomeIcons.search,
                      color: Color(0xff317183),
                      size: 30,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _nomeProd.clear();
                        controller.updnomeProduto('');
                        FocusScope.of(context).unfocus();
                      },
                      child: Icon(
                        FontAwesomeIcons.eraser,
                        color: Color(0xff317183),
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Observer(builder: (BuildContext context) {
              return Expanded(
                child: StreamBuilder<List<Produto>>(
                  stream: Context.instance.getProduto(controller.nomeProduto),
                  initialData: [],
                  builder: (context, snapshot) {
                    List<Produto> prod = snapshot.data;
                    if (!snapshot.hasData || snapshot.data.length == 0) {
                      return Center(child: Text('Nada encontrado'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: prod.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: ExpansionTileCard(
                                title: Text(
                                  prod[index].nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xff317183),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      prod[index].preco.toString() +
                                          ' - ' +
                                          prod[index].unidade,
                                      style: TextStyle(
                                        color: Color(0xff46997D),
                                      ),
                                    ),
                                    Spacer(),
                                    prod[index].quant > 0
                                        ? Text(
                                            prod[index].total.toString(),
                                            style: TextStyle(
                                              color: Color(0xff46997D),
                                            ),
                                          )
                                        : Text(''),
                                  ],
                                ),
                                children: [
                                  Divider(
                                    thickness: 1,
                                    height: 1,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: TouchSpin(
                                        min: 0,
                                        //max: 100,
                                        step: 1,
                                        value: 0,
                                        displayFormat: NumberFormat.currency(
                                            locale: 'en_US', symbol: ''),
                                        textStyle: TextStyle(fontSize: 36),
                                        iconSize: 48.0,
                                        addIcon: Icon(Icons.add_circle_outline),
                                        subtractIcon:
                                            Icon(Icons.remove_circle_outline),
                                        iconActiveColor: Colors.green,
                                        iconDisabledColor: Colors.grey,
                                        iconPadding: EdgeInsets.all(20),
                                        onChanged: (val) async {
                                          controllerPed.salvarItem(
                                              val, prod[index]);
                                          // print(val);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
