import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:vendas_app/src/shared/format.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/view/cliente_data_view.dart';

//import '../../../app/datamodule/dmlocal.dart';

import 'package:vendas_app/src/view/components/icon_header_view.dart';

import 'package:vendas_app/src/app_controller.dart';

class ClienteSearch extends StatefulWidget {
  @override
  _ClienteSearchState createState() => _ClienteSearchState();
}

class _ClienteSearchState extends State<ClienteSearch> {
  TextEditingController _nomeCli = TextEditingController();

  var controller = new AppController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Context.instance.id = '';
            // Basedados.instance.cnpj = '';
            // Basedados.instance.nome = '';
            // Basedados.instance.fantasia = '';
            // Basedados.instance.endereco = '';
            // Basedados.instance.bairro = '';
            // Basedados.instance.numero = '';
            // Basedados.instance.cep = '';
            // Basedados.instance.telefone = '';
            // Basedados.instance.municipio = '';
            // Basedados.instance.lat = '';
            // Basedados.instance.lng = '';
            // Basedados.instance.uf = '';
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ClienteData()));
          },
          child: Icon(Icons.add, size: 40),
          backgroundColor: Color(0xff46997D),
          tooltip: 'Adicionar clientes',
        ),
        body: Column(
          children: [
            Stack(
              children: [
                IconeHeader(
                  icone: Icons.supervisor_account,
                  titulo: 'Clientes registrados',
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
                      Navigator.of(context).pop();
                    },
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: Observer(
                    builder: (_) {
                      return Text(
                        controller.totCli.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      );
                    },
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
                              child: ExpansionTileCard(
                                title: Text(
                                  cli[index].nome,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Color(0xff317183),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  cli[index].municipio + ' - ' + cli[index].uf,
                                  style: TextStyle(
                                    color: Color(0xff46997D),
                                  ),
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
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                '${cli[index].endereco}, ${cli[index].numero}\n',
                                            style: TextStyle(
                                                color: Color(0xff317183),
                                                fontWeight: FontWeight.w600),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text:
                                                    '${cli[index].cep} - ${cli[index].bairro}\n',
                                                style: TextStyle(
                                                    color: Color(0xff317183),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              TextSpan(
                                                text: '${cli[index].telefone}',
                                                style: TextStyle(
                                                    color: Color(0xff317183),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  ButtonBar(
                                    alignment: MainAxisAlignment.spaceAround,
                                    buttonHeight: 52,
                                    buttonMinWidth: 90,
                                    children: [
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Column(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.phone,
                                              color: cli[index].telefone == ''
                                                  ? Colors.red
                                                  : Color(0xff46997D),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                            ),
                                            Text(
                                              'Ligar',
                                              style: TextStyle(
                                                color: cli[index].telefone == ''
                                                    ? Colors.red
                                                    : Color(0xff46997D),
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () {
                                          if (cli[index].telefone != '') {
                                            //ligar para o numero
                                            String fone = cli[index]
                                                .telefone
                                                .replaceAll('(', '');
                                            fone = fone.replaceAll(')', '');
                                            fone = fone.replaceAll(' ', '');
                                            fone = fone.replaceAll('-', '');
                                            fone = fone.trim();
                                            if (fone.substring(0, 1) != '0') {
                                              fone = '0' + fone;
                                            }
                                            FlutterPhoneDirectCaller.callNumber(
                                                fone);
                                          }
                                        },
                                      ),
                                      FlatButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.room,
                                              color: cli[index].lat == '' ||
                                                      cli[index].lng == ''
                                                  ? Colors.red
                                                  : Color(0xff46997D),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 2,
                                              ),
                                            ),
                                            Text(
                                              'Mapa',
                                              style: TextStyle(
                                                color: cli[index].lat == '' ||
                                                        cli[index].lng == ''
                                                    ? Colors.red
                                                    : Color(0xff46997D),
                                              ),
                                            )
                                          ],
                                        ),
                                        onPressed: () async {
                                          if (cli[index].lat != '' ||
                                              cli[index].lng != '') {
                                            MapsLauncher.launchCoordinates(
                                                double.tryParse(cli[index].lat),
                                                double.tryParse(
                                                    cli[index].lng));
                                          } else {
                                            MapsLauncher.launchQuery(
                                                cli[index].endereco +
                                                    ' ' +
                                                    cli[index].numero +
                                                    ' ' +
                                                    cli[index].bairro +
                                                    ' ' +
                                                    cli[index].municipio +
                                                    ' ' +
                                                    cli[index].uf +
                                                    '  Brasil');
                                          }
                                          //  {

                                          //   await _getLocation();
                                          //   showCupertinoDialog(
                                          //       context: context,
                                          //       builder: (context) =>
                                          //           CupertinoAlertDialog(
                                          //             title: Column(
                                          //               children: [
                                          //                 Icon(
                                          //                   Icons.room,
                                          //                   size: 40,
                                          //                 ),
                                          //                 SizedBox(height: 5),
                                          //                 Text('Coordenadas'),
                                          //                 SizedBox(height: 5),
                                          //                 Column(
                                          //                   crossAxisAlignment:
                                          //                       CrossAxisAlignment
                                          //                           .start,
                                          //                   mainAxisAlignment:
                                          //                       MainAxisAlignment
                                          //                           .start,
                                          //                   children: [
                                          //                     Text('lat: ' +
                                          //                         _lat),
                                          //                     Text('lng: ' +
                                          //                         _lng),
                                          //                   ],
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //             actions: [
                                          //               CupertinoDialogAction(
                                          //                 child: Text('Salvar'),
                                          //                 onPressed: () {
                                          //                   //alterar no bd
                                          //                   if (_lat != '') {
                                          //                     Basedados.instance
                                          //                         .updCliente(
                                          //                       Cliente(
                                          //                         id: cli[index]
                                          //                             .id,
                                          //                         nome:
                                          //                             cli[index]
                                          //                                 .nome,
                                          //                         fantasia: cli[
                                          //                                 index]
                                          //                             .fantasia,
                                          //                         endereco: cli[
                                          //                                 index]
                                          //                             .endereco,
                                          //                         numero: cli[
                                          //                                 index]
                                          //                             .numero,
                                          //                         bairro: cli[
                                          //                                 index]
                                          //                             .bairro,
                                          //                         cep:
                                          //                             cli[index]
                                          //                                 .cep,
                                          //                         lat: _lat,
                                          //                         lng: _lng,
                                          //                         municipio: cli[
                                          //                                 index]
                                          //                             .municipio,
                                          //                         telefone: cli[
                                          //                                 index]
                                          //                             .telefone,
                                          //                         uf: cli[index]
                                          //                             .uf,
                                          //                       ),
                                          //                     );
                                          //                   }
                                          //                   Navigator.pop(
                                          //                       context);
                                          //                 },
                                          //               ),
                                          //               CupertinoDialogAction(
                                          //                 child: Text('Fechar'),
                                          //                 onPressed: () =>
                                          //                     Navigator.pop(
                                          //                         context),
                                          //               ),
                                          //             ],
                                          //           ));
                                          // }
                                        },
                                      ),
                                      FlatButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Color(0xff46997D),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 2,
                                                ),
                                              ),
                                              Text(
                                                'Editar',
                                                style: TextStyle(
                                                  color: Color(0xff46997D),
                                                ),
                                              )
                                            ],
                                          ),
                                          onPressed: () {
                                            Context.instance.id = cli[index].id;
                                            Context.instance.cnpj =
                                                cli[index].cnpj;
                                            Context.instance.nome =
                                                cli[index].nome;
                                            Context.instance.fantasia =
                                                cli[index].fantasia;
                                            Context.instance.endereco =
                                                cli[index].endereco;
                                            Context.instance.bairro =
                                                cli[index].bairro;
                                            Context.instance.cep =
                                                cli[index].cep;
                                            Context.instance.numero =
                                                cli[index].numero;
                                            Context.instance.telefone =
                                                cli[index].telefone;
                                            Context.instance.municipio =
                                                cli[index].municipio;
                                            Context.instance.lat =
                                                cli[index].lat;
                                            Context.instance.lng =
                                                cli[index].lng;
                                            Context.instance.uf = cli[index].uf;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ClienteData(
                                                            //   clienteEnt: cli[index],
                                                            )));
                                            Navigator.of(context)
                                                .pushNamed('clienteFicha');
                                          }),
                                    ],
                                  )
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
