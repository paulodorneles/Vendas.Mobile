class CategoriaModel {
  int catId;
  String catNome;

  CategoriaModel({this.catId, this.catNome});

  CategoriaModel.fromJson(Map<String, dynamic> json) {
    catId = json['cat_Id'];
    catNome = json['cat_Nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cat_Id'] = this.catId;
    data['cat_Nome'] = this.catNome;
    return data;
  }
}
