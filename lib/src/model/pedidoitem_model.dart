class PedidoItemModel {
  int peiId;
  String peiIdPedido;
  int peiIdProduto;
  int peiQtde;
  String peiSubTotal;

  PedidoItemModel(
      {this.peiId,
      this.peiIdPedido,
      this.peiIdProduto,
      this.peiQtde,
      this.peiSubTotal});

  PedidoItemModel.fromJson(Map<String, dynamic> json) {
    peiId = json['pei_Id'];
    peiIdPedido = json['pei_IdPedido'];
    peiIdProduto = json['pei_IdProduto'];
    peiQtde = json['pei_Qtde'];
    peiSubTotal = json['pei_SubTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pei_Id'] = this.peiId;
    data['pei_IdPedido'] = this.peiIdPedido;
    data['pei_IdProduto'] = this.peiIdProduto;
    data['pei_Qtde'] = this.peiQtde;
    data['pei_SubTotal'] = this.peiSubTotal;
    return data;
  }
}
