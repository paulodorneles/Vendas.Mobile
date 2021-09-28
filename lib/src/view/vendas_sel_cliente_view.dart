import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:vendas_app/src/shared/format.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/view/components/icon_header_view.dart';
import 'package:vendas_app/src/view/vendas_sel_produto.view.dart';

import 'package:vendas_app/src/app_controller.dart';


class ClienteSel extends StatefulWidget {
  @override
  _ClienteSelState createState() => _ClienteSelState();
}

class _ClienteSelState extends State<ClienteSel> {
  TextEditingController _nomeCli = TextEditingController();
  var controller = new AppController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                IconeHeader(
                  icone: Icons.supervisor_account,
                  titulo: 'Selecionar cliente',
                  cor1: Color(0xff317183),
                  cor2: Color(0xff46997D),
                  altura: 200,
                ),
                Positioned(
                  top: 15,
                  left: 15,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 40,
                    onPressed: () {
                      //Modular.to.pop();
                      Navigator.of(context).pop();  
                    },
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Container(
              height: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                child: TextField(
                  controller: _nomeCli,
                  onChanged: (value) async {
                    controller.updnomeCliente(value);
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
                        _nomeCli.clear();
                        controller.updnomeCliente('');
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
                child: StreamBuilder<List<Cliente>>(
                  stream: Context.instance.getCliente(controller.nomeCliente),
                  initialData: [],
                  builder: (context, snapshot) {
                    List<Cliente> cli = snapshot.data;
                    if (!snapshot.hasData || snapshot.data.length == 0) {
                      return Center(child: Text('Nada encontrado'));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: cli.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: InkWell(
                                splashColor: Colors.green,
                                onTap: () async {
                                  // print(cli[index].nome);
                                  controller.updpNomeCliente(cli[index].nome);
                                  controller.updpedidoClienteId(cli[index].id);
                                  controller.updpedidoCodigo();
                                  controller.updpedidoSubtotal('R\$ 0,00');
                                  controller.updpedidoCidade(
                                      cli[index].municipio +
                                          ' - ' +
                                          cli[index].uf);
                                  // print(controller.pedidoCodigo);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PedProduto()));

                                  //Navigator.of(context).push(route);     

                                  //Modular.to.pushNamed('pedidoProduto');
                                },
                                child: ListTile(
                                  title: Text(cli[index].nome),
                                  subtitle: Text(cli[index].municipio +
                                      ' - ' +
                                      cli[index].uf),
                                ),
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
