import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter_modular/flutter_modular.dart';
//import 'package:location/location.dart';
//import 'package:pedidos/app/app_controller.dart';
import 'package:vendas_app/src/context/mycontext.dart';
import 'package:vendas_app/src/shared/format.dart';

import 'package:vendas_app/src/view/components/show_message_view.dart';
import 'package:vendas_app/src/view/components/icon_header_view.dart';
import 'package:http/http.dart' as http;


class ClienteData extends StatefulWidget {
  @override
  _ClienteDataState createState() => _ClienteDataState();
}

class _ClienteDataState extends State<ClienteData> {
  TextEditingController _cpfcnpj = TextEditingController();
  TextEditingController _nome = TextEditingController();
  TextEditingController _fantasia = TextEditingController();
  TextEditingController _endereco = TextEditingController();
  TextEditingController _bairro = TextEditingController();
  TextEditingController _numero = TextEditingController();
  TextEditingController _cep = TextEditingController();
  TextEditingController _telefone = TextEditingController();
  TextEditingController _municipio = TextEditingController();
  TextEditingController _uf = TextEditingController();

  final FocusNode _cpfcnpjF = FocusNode();
  final FocusNode _nomeF = FocusNode();
  final FocusNode _fantasiaF = FocusNode();
  final FocusNode _enderecoF = FocusNode();
  final FocusNode _bairroF = FocusNode();
  final FocusNode _numeroF = FocusNode();
  final FocusNode _cepF = FocusNode();
  final FocusNode _telefoneF = FocusNode();
  final FocusNode _municipioF = FocusNode();
  final FocusNode _ufF = FocusNode();

  Future<void> consultaCnpj() async {
    var url = 'http://www.receitaws.com.br/v1/cnpj/' + _cpfcnpj.text;

    final resposta = await http.get(Uri.parse(url));
    if (resposta.statusCode == 200) {
      if (resposta.body != '{"status": "ERROR", "message": "CNPJ inválido"}') {
        var parsedJson = json.decode(resposta.body);
        _cpfcnpj.text = parsedJson['cnpj'];
        _nome.text = parsedJson['nome'];
        _fantasia.text = parsedJson['fantasia'];
        _bairro.text = parsedJson['bairro'];
        _endereco.text = parsedJson['logradouro'];
        _numero.text = parsedJson['numero'];
        _cep.text = parsedJson['cep'];
        _municipio.text = parsedJson['municipio'];
        _uf.text = parsedJson['uf'];
        _telefone.text = parsedJson['telefone'];
      }
    }
    return null;
  }

  //final Location location = Location();

  String _lat = '';
  String _lng = '';

  Future<void> _getLocation() async {
    try {
      //final LocationData _locationResult = await location.getLocation();
      setState(() {
      //  _lat = '${_locationResult.latitude}';
      //  _lng = '${_locationResult.longitude}';
      });
    } catch (e) {}
  }

  _carregaDados() {
    final bd = Context.instance;

    if (bd.id != '') {
      _cpfcnpj.text = bd.cnpj;
      _nome.text = bd.nome;
      _fantasia.text = bd.fantasia;
      _endereco.text = bd.endereco;
      _bairro.text = bd.bairro;
      _numero.text = bd.numero;
      _cep.text = bd.cep;
      _telefone.text = bd.telefone;
      _municipio.text = bd.municipio;
      _uf.text = bd.uf;
      _lat = bd.lat;
      _lng = bd.lng;
    }
  }

  @override
  void initState() {
    super.initState();
    _carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 227, 233, 235),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  IconeHeader(
                    icone: Icons.supervisor_account,
                    titulo: 'Cadastro de Clientes',
                    cor1: Color(0xff317183),
                    cor2: Color(0xff46997D),
                    altura: 200,
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'cpf ou cnpj',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: _cpfcnpj,
                          focusNode: _cpfcnpjF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _cpfcnpjF, _nomeF);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: IconButton(
                        tooltip: 'Consultar na receita',
                        icon: Icon(
                          Icons.search,
                          color: Colors.green,
                          size: 40,
                        ),
                        onPressed: () async {
                          String _cpf = _cpfcnpj.text
                              .replaceAll('.', '')
                              .replaceAll('/', '')
                              .replaceFirst('-', '');
                          _cpfcnpj.text = _cpf;
                          print(_cpf);
                          _nome.clear();
                          await consultaCnpj();
                          if (_fantasia.text.isEmpty) {
                            _fantasia.text = _nome.text;
                          }
                          if (_nome.text.isEmpty) {
                            showMessage(
                                2, 'Consulta Cnpj', 'CNPJ inválido', context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'nome',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _nome,
                          focusNode: _nomeF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _nomeF, _fantasiaF);
                          },
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'fantasia',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _fantasia,
                          focusNode: _fantasiaF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _fantasiaF, _enderecoF);
                          },
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'endereço',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _endereco,
                          focusNode: _enderecoF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _enderecoF, _bairroF);
                          },
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'bairro',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _bairro,
                          focusNode: _bairroF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _bairroF, _numeroF);
                          },
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'nr',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _numero,
                          focusNode: _numeroF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _numeroF, _cepF);
                          },
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'cep',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: _cep,
                          focusNode: _cepF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _cepF, _telefoneF);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'telefone',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          controller: _telefone,
                          focusNode: _telefoneF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _telefoneF, _municipioF);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'municipio',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.next,
                          controller: _municipio,
                          focusNode: _municipioF,
                          onFieldSubmitted: (term) {
                            _pulaCampo(context, _municipioF, _ufF);
                          },
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'uf',
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          textInputAction: TextInputAction.done,
                          controller: _uf,
                          focusNode: _ufF,
                          inputFormatters: [
                            UpperCaseTextFormatter(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: RaisedButton(
                  textColor: Colors.white70,
                  color: Color(0xff317183),
                  child: Text(
                    'Salvar',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  onPressed: () async {
                    if (_lat == '') await _getLocation();
                    //gravar
                    if (Context.instance.id == '') {
                      await Context.instance.addCliente(Cliente(
                        id: '${controller.idUsuario}' +
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        nome: _nome.text,
                        cnpj: _cpfcnpj.text,
                        bairro: _bairro.text ?? '',
                        cep: _cep.text ?? '00.000-00',
                        endereco: _endereco.text ?? '',
                        fantasia: _fantasia.text ?? _nome.text,
                        lat: _lat,
                        lng: _lng,
                        municipio: _municipio.text ?? '',
                        numero: _numero.text ?? 'S/N',
                        telefone: _telefone.text ?? '',
                        uf: _uf.text ?? '',
                        alterado: 1,
                      ));
                    } else {
                      await Context.instance.updCliente(Cliente(
                        id: Context.instance.id,
                        nome: _nome.text,
                        cnpj: _cpfcnpj.text,
                        bairro: _bairro.text ?? '',
                        cep: _cep.text ?? '00.000-00',
                        endereco: _endereco.text ?? '',
                        fantasia: _fantasia.text ?? _nome.text,
                        lat: _lat,
                        lng: _lng,
                        municipio: _municipio.text ?? '',
                        numero: _numero.text ?? 'S/N',
                        telefone: _telefone.text ?? '',
                        uf: _uf.text ?? '',
                        alterado: 1,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_pulaCampo(BuildContext context, FocusNode atual, FocusNode proximo) {
  atual.unfocus();
  FocusScope.of(context).requestFocus(proximo);
}
