import 'package:vendas_app/src/model/pedidoitem_model.dart';

class PedidoModel {
  String pedId;
  int pedIdVendedor;
  String pedIdCliente;
  String pedData;
  int pedConferido;
  List<PedidoItemModel> pedidoItemModel;

  PedidoModel(
      {this.pedId,
      this.pedIdVendedor,
      this.pedIdCliente,
      this.pedData,
      this.pedConferido,
      this.pedidoItemModel});

  PedidoModel.fromJson(Map<String, dynamic> json) {
    pedId = json['ped_Id'];
    pedIdVendedor = json['ped_IdVendedor'];
    pedIdCliente = json['ped_IdCliente'];
    pedData = json['ped_Data'];
    pedConferido = json['ped_Conferido'];
    if (json['pedidoItemEntity'] != null) {
      pedidoItemModel = new List<PedidoItemModel>();
      json['pedidoItemEntity'].forEach((v) {
        pedidoItemModel.add(new PedidoItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ped_Id'] = this.pedId;
    data['ped_IdVendedor'] = this.pedIdVendedor;
    data['ped_IdCliente'] = this.pedIdCliente;
    data['ped_Data'] = this.pedData;
    data['ped_Conferido'] = this.pedConferido;
    if (this.pedidoItemModel != null) {
      data['pedidoItemEntity'] =
          this.pedidoItemModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
