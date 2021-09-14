
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendas_app/src/view/components/menu_item_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MenuView extends StatefulWidget {
  @override
  _MenuView createState() => _MenuView();
}

class _MenuView extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff317183),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                  color: Colors.white,
                ),
                //nome do vendedor
                Container(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Observer(builder: (_) {
                        return Text(
                          'Paulo',
                          //controller.nomevendedor,
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.end,
                        );
                      }),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
          //titulo do menu principal
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Row(
              children: <Widget>[
                Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Principal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          SizedBox(height: 20),
          //itens do menu
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(75),
              ),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25, right: 20),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: <Widget>[
                        Material(
                          child: Observer(builder: (_) {
                            return MenuItem(
                              img: 'images/cliente.png',
                              header: 'Clientes',
                              botton: // controller.totCli.toString() +
                                  ' clientes registrados',
                              cor: Color(0xff317183),
                              onPress: () {
                               // Modular.to.pushNamed('clientelista');
                              },
                            );
                          }),
                        ),
                        Material(
                          child: Observer(builder: (_) {
                            return MenuItem(
                              img: 'images/produto.png',
                              header: 'Produtos',
                              botton:// controller.totProd.toString() +
                                  ' produtos registrados',
                              onPress: () {
                           //     Modular.to.pushNamed('produtoLista');
                              },
                            );
                          }),
                        ),
                        Material(
                          child: Observer(builder: (_) {
                            return MenuItem(
                              img: 'images/pedidos.png',
                              header: 'Pedidos',
                              botton: //controller.totPed.toString() +
                                  '1 pedidos registrados',
                              onPress: () {
                              //  Modular.to.pushNamed('pedidoLista');
                              },
                            );
                          }),
                        ),
                        Material(
                          child: MenuItem(
                            img: 'images/vender.png',
                            header: 'Novo pedido',
                            botton: 'Registrar um novo pedido',
                            onPress: () {
                            //  Modular.to.pushNamed('clienteSel');
                            },
                          ),
                        ),
                        Material(
                          child: MenuItem(
                            img: 'images/sincro.png',
                            header: 'Sincronizar',
                            botton: 'Enviar e atualizar a base',
                            onPress: () {
                             // print(controller.totCat);
                             // Modular.to.pushNamed('sincro');
                            },
                          ),
                        ),
                        Material(
                          child: MenuItem(
                            img: 'images/config.png',
                            header: 'Configurar',
                            botton: 'Configurações gerais',
                            onPress: () {
                             // Modular.to.pushNamed('config');
                            },
                            cor: Color(0xFF21BFBD),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
