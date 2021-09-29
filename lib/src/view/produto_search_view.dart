import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vendas_app/src/shared/format.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/view/components/icon_header_view.dart';
import 'package:vendas_app/src/app_controller.dart';

class ProdutoSearch extends StatefulWidget {
  @override
  _ProdutoSearchState createState() => _ProdutoSearchState();
}

class _ProdutoSearchState extends State<ProdutoSearch> {
  var controller = new AppController();
  TextEditingController _nomeProd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                IconeHeader(
                  icone: Icons.inbox,
                  titulo: 'Produtos registrados',
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
                        controller.totProd.toString(),
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
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Código: ' + prod[index].id.toString(),
                                    style: TextStyle(
                                      color: Color(0xff317183),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    prod[index].nome,
                                    style: TextStyle(
                                      color: Color(0xff317183),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Unidade: ' + prod[index].unidade,
                                        style: TextStyle(
                                          color: Color(0xff317183),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'Valor: ' +
                                            prod[index].preco.toString(),
                                        style: TextStyle(
                                          color: Color(0xff317183),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 1,
                                    color: Color(0xff317183),
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
