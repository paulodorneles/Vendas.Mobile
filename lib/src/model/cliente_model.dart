import 'package:vendas_app/src/context/mycontext.dart';

class ClientesModel {
  factory ClientesModel.fromJson(Map<String, dynamic> json) {
    Context.instance.addCliente(
      Cliente(
        id: json["UUID"],
        cnpj: json["CNPJCPF"],
        nome: json["NOME"],
        bairro: json["BAIRRO"] ?? '',
        cep: json["CEP"] ?? '00.000-00',
        endereco: json["ENDERECO"] ?? '',
        fantasia: json["FANTASIA"] ?? json["NOME"],
        lat: json["LAT"] ?? '',
        lng: json["LNG"] ?? '',
        municipio: json["MUNICIPIO"] ?? '',
        numero: json["NUMERO"] ?? 'S/N',
        telefone: json["TELEFONE"] ?? '',
        uf: json["UF"] ?? '',
        alterado: 0,
      ),
    );
    return null;
  }
}
