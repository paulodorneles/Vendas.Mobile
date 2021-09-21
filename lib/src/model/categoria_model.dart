import 'package:vendas_app/src/context/mycontext.dart';

class CategoriasModel {
  factory CategoriasModel.fromJson(Map<String, dynamic> json) {
    Context.instance.addCategoria(
      Categoria(
        id: json['ID'],
        nome: json['NOME'],
      ),
    );
    return null;
  }
}
