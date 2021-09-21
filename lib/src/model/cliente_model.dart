class ClienteModel {
  String cliId;
  int cliIdRota;
  String cliNome;
  String cliFantasia;
  String cliTipoPessoa;
  String cliCnpjCpf;
  String cliEndereco;
  String cliNumero;
  String cliBairro;
  String cliCep;
  String cliTelefone;
  String cliCelular;
  String cliBloqueado;
  String cliUltimaCompra;
  String cliUF;
  String cliMunicipio;
  String cliLat;
  String cliLng;

  ClienteModel(
      {this.cliId,
      this.cliIdRota,
      this.cliNome,
      this.cliFantasia,
      this.cliTipoPessoa,
      this.cliCnpjCpf,
      this.cliEndereco,
      this.cliNumero,
      this.cliBairro,
      this.cliCep,
      this.cliTelefone,
      this.cliCelular,
      this.cliBloqueado,
      this.cliUltimaCompra,
      this.cliUF,
      this.cliMunicipio,
      this.cliLat,
      this.cliLng});

  ClienteModel.fromJson(Map<String, dynamic> json) {
    cliId = json['cli_Id'];
    cliIdRota = json['cli_IdRota'];
    cliNome = json['cli_Nome'];
    cliFantasia = json['cli_Fantasia'];
    cliTipoPessoa = json['cli_TipoPessoa'];
    cliCnpjCpf = json['cli_CnpjCpf'];
    cliEndereco = json['cli_Endereco'];
    cliNumero = json['cli_Numero'];
    cliBairro = json['cli_Bairro'];
    cliCep = json['cli_Cep'];
    cliTelefone = json['cli_Telefone'];
    cliCelular = json['cli_Celular'];
    cliBloqueado = json['cli_Bloqueado'];
    cliUltimaCompra = json['cli_UltimaCompra'];
    cliUF = json['cli_UF'];
    cliMunicipio = json['cli_Municipio'];
    cliLat = json['cli_Lat'];
    cliLng = json['cli_Lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cli_Id'] = this.cliId;
    data['cli_IdRota'] = this.cliIdRota;
    data['cli_Nome'] = this.cliNome;
    data['cli_Fantasia'] = this.cliFantasia;
    data['cli_TipoPessoa'] = this.cliTipoPessoa;
    data['cli_CnpjCpf'] = this.cliCnpjCpf;
    data['cli_Endereco'] = this.cliEndereco;
    data['cli_Numero'] = this.cliNumero;
    data['cli_Bairro'] = this.cliBairro;
    data['cli_Cep'] = this.cliCep;
    data['cli_Telefone'] = this.cliTelefone;
    data['cli_Celular'] = this.cliCelular;
    data['cli_Bloqueado'] = this.cliBloqueado;
    data['cli_UltimaCompra'] = this.cliUltimaCompra;
    data['cli_UF'] = this.cliUF;
    data['cli_Municipio'] = this.cliMunicipio;
    data['cli_Lat'] = this.cliLat;
    data['cli_Lng'] = this.cliLng;
    return data;
  }
}
