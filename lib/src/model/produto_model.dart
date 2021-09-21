class ProdutoModel {
  int proId;
  String proNome;
  int proIdCategoria;
  String proUnidade;
  int proPreco;

  ProdutoModel(
      {this.proId,
      this.proNome,
      this.proIdCategoria,
      this.proUnidade,
      this.proPreco});

  ProdutoModel.fromJson(Map<String, dynamic> json) {
    proId = json['pro_Id'];
    proNome = json['pro_Nome'];
    proIdCategoria = json['pro_IdCategoria'];
    proUnidade = json['pro_Unidade'];
    proPreco = json['pro_Preco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pro_Id'] = this.proId;
    data['pro_Nome'] = this.proNome;
    data['pro_IdCategoria'] = this.proIdCategoria;
    data['pro_Unidade'] = this.proUnidade;
    data['pro_Preco'] = this.proPreco;
    return data;
  }
}
