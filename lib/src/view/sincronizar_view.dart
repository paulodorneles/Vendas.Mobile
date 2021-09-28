import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
//import '../../../app/datamodule/dm_remoto.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/app_controller.dart';
import 'package:vendas_app/src/controller/sincronizar_controller.dart';
import 'package:vendas_app/src/view/components/icon_header_view.dart';
import 'package:vendas_app/src/view/components/botao_customizado.dart';
import 'package:vendas_app/src/view/components/item_listtile.dart';

ProgressDialog pr;

class SincroPage extends StatefulWidget {
  @override
  _SincroPageState createState() => _SincroPageState();
}

class _SincroPageState extends State<SincroPage> {
  bool categ = false;
  bool cliente = false;
  bool pedido = false;
  bool produto = false;
  var controllerSinc = new SincronizarController();
  var controller = new AppController();


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IconeHeader(
            icone: FontAwesomeIcons.database,
            titulo: 'Sincronização',
            cor1: Color(0xff317183),
            cor2: Color(0xff46997D),
          ),
          Observer(builder: (_) {
            return ItemList(
              cor: Color(0xff317183),
              titulo: 'Categorias',
              subtitulo: 'Quantidade: ${controller.totCat}',
              item: Switch(
                  activeColor: Color(0xff317183),
                  value: categ,
                  onChanged: (bool vlr) {
                    setState(() {
                      categ = vlr;
                    });
                  }),
              icone: FontAwesomeIcons.boxOpen,
            );
          }),
          Observer(builder: (_) {
            return ItemList(
              cor: Color(0xff46997D),
              titulo: 'Clientes',
              subtitulo: 'Quantidade: ${controller.totCli}',
              item: Switch(
                  activeColor: Color(0xff46997D),
                  value: cliente,
                  onChanged: (bool vlr) {
                    setState(() {
                      cliente = vlr;
                    });
                  }),
              icone: FontAwesomeIcons.userAlt,
            );
          }),
          Observer(builder: (_) {
            return ItemList(
              cor: Color(0xff317183),
              titulo: 'Pedidos',
              subtitulo: 'Quantidade: ${controller.totPed}',
              item: Switch(
                  activeColor: Color(0xff317183),
                  value: pedido,
                  onChanged: (bool vlr) {
                    setState(() {
                      pedido = vlr;
                    });
                  }),
              icone: Icons.settings,
            );
          }),
          Observer(builder: (_) {
            return ItemList(
              cor: Color(0xff46997D),
              titulo: 'Produtos',
              subtitulo: 'Qtde: ${controller.totProd}',
              item: Switch(
                  activeColor: Color(0xff46997D),
                  value: produto,
                  onChanged: (bool vlr) {
                    setState(() {
                      produto = vlr;
                    });
                  }),
              icone: Icons.settings,
            );
          }),
          Expanded(child: Container()),
          BotaoInfo(
            icone: Icons.settings,
            cor1: Color(0xff317183),
            cor2: Color(0xff46997D),
            texto: 'Sincronizar',
            onPress: () async {
              if (cliente == true ||
                  pedido == true ||
                  produto == true) {
                pr = ProgressDialog(context);
                pr.update(message: 'Aguarde...');
                pr.show();

                if (pedido) {
                  pr.update(message: 'Enviando pedidos...');
                  await controllerSinc.enviaPedidos();
                }                

                if (cliente) {
                  pr.update(message: 'Atualizando Clientes...');
                  controllerSinc.buscarCliente();
                  // await buscaClientes(controller.clienteRemoto);
                  // int c = await Basedados.instance.countCl();
                  // controller.updtotCli(c);
                }

                if (produto) {
                  pr.update(message: 'Atualizando Produtos...');
                  controllerSinc.buscarProduto();
                  int c = await Context.instance.countPr();
                  controller.updTotPro(c);
                }
                await controller.gravarArqIni();
                pr.hide();
              }
              //volta ao menu
              Navigator.of(context).pop();
              //Modular.to.pop();
            },
          ),
        ],
      ),
    );
  }
}
