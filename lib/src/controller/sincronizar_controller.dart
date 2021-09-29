/*import 'package:pedidos/src/repository/cliente_repository.dart';
import 'package:pedidos/src/repository/condpagto_repository.dart';
import 'package:pedidos/src/repository/formapagto_repository.dart';
import 'package:pedidos/src/repository/produto_repository.dart';
import 'package:pedidos/src/repository/pedido_repository.dart';
import 'package:pedidos/src/repository/pedidoitens_repository.dart';
import 'package:pedidos/src/repository/pedidoitensbrinde_repository.dart';
import 'package:pedidos/src/repository/grupo_repository.dart';
import 'package:pedidos/src/repository/tipoenviomerc_repository.dart';
import 'package:pedidos/src/api/cliente_api.dart';
import 'package:pedidos/src/api/produto_api.dart';
import 'package:pedidos/src/api/grupo_api.dart';
import 'package:pedidos/src/api/tipoenviomercadoria_api.dart';
import 'package:pedidos/src/api/parametros_api.dart';
import 'package:pedidos/src/api/condpagto_api.dart';
import 'package:pedidos/src/api/formapagto_api.dart';
import 'package:pedidos/src/api/vendas_api.dart';
import 'package:pedidos/src/model/cliente_entity.dart';
import 'package:pedidos/src/model/produto_entity.dart';
import 'package:pedidos/src/model/formapagto_entity.dart';
import 'package:pedidos/src/model/condpagto_entity.dart';
import 'package:pedidos/src/model/pedido_entity.dart';
import 'package:pedidos/src/model/grupo_entity.dart';
import 'package:pedidos/src/model/tipoenviomercadoria_entity.dart';
import 'package:pedidos/src/model/parametros_entity.dart';
import 'package:pedidos/src/model/pedidoitens_entity.dart';
import 'package:pedidos/src/model/pedidoitensbrinde_entity.dart';
import 'package:pedidos/src/shared/utilitarios.dart';
import 'package:pedidos/src/controller/usuario_controller.dart';  */

import 'package:vendas_app/src/api/cliente_api.dart';
import 'package:vendas_app/src/api/categoria_api.dart';
import 'package:vendas_app/src/api/produto_api.dart';
import 'package:vendas_app/src/api/vendas_api.dart';
import 'package:vendas_app/src/context/mycontext.dart';

import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:vendas_app/src/model/cliente_model.dart';
import 'package:vendas_app/src/model/pedido_model.dart';
import 'package:vendas_app/src/model/pedidoitem_model.dart';

part 'sincronizar_controller.g.dart';

class SincronizarController = _SincronizarController
    with _$SincronizarController;

abstract class _SincronizarController with Store {
  @observable
  String statusCliente = "Status";

  @observable
  String statusCondPgto = "Status";

  @observable
  String statusProduto = "Status";

  @observable
  String statusVenda = "Status";

  @action
  void setStatusCliente(String value) => statusCliente = value;

  @action
  void setStatusProduto(String value) => statusProduto = value;

  @action
  void setStatusCondPagto(String value) => statusCondPgto = value;

  @action
  void setStatusVendas(String value) => statusVenda = value;

  /* var clienteRep = new ClienteRepository();
  var tipoRep = new TipoEnvioMercadoriaRepository();
  var grupoRep = new GrupoRepository();
  var produtoRep = new ProdutoRepository();
  var formaRep = new FormaPagtoRepository();
  var condRep = new CondPagtoRepository();
  var controllerUsu = new UsuarioController();  */

  // var util = new Util();

  Future<void> sincronizarDados(bool cliente, bool produto, bool vendas) async {
    if (cliente) {
      buscarCliente();
    }
    if (produto) {
      buscarProduto();
    }
    if (vendas) {
      buscarProduto();
    }
  }

  @action
  void buscarCliente() {
    setStatusCliente('Buscando clientes');
    ClienteApi.getClientes().then((response) {
      final lista = json.decode(response.body);

      if (response.statusCode == 200) {
        //var cliente = new List<Clientes>(lista.length);
        var itemCliente;
        Context.instance.delCliente();
        var count = 0;
        while (count <= lista.length) {
          itemCliente = lista[count];
          Context.instance.addCliente(Cliente(
            id: itemCliente['cli_Id'],
            nome: itemCliente['cli_Nome'],
            cnpj: itemCliente['cli_CnpjCpf'],
            bairro: itemCliente['cli_Bairro'],
            cep: itemCliente['cli_Cep'],
            endereco: itemCliente['cli_Endereco'],
            fantasia: itemCliente['cli_Fantasia'],
            lat: itemCliente['cli_Lat'],
            lng: itemCliente['cli_Lng'],
            municipio: itemCliente['cli_Municipio'],
            numero: itemCliente['cli_Numero'],
            telefone: itemCliente['cli_Telefone'],
            uf: itemCliente['cli_UF'],
            alterado: 1,
          ));

          count++;
          setStatusCliente('Atualizado ' +
              count.toString() +
              ' de ' +
              lista.length.toString());
        }
      } else {
        setStatusCliente('Erro ao buscar dados!');
      }
    });
  }

  @action
  void buscarProduto() {
    setStatusProduto('Buscando produtos');
    ProdutoApi.getProdutos().then((response) {
      final lista = json.decode(response.body);
      var itemProduto;

      if (response.statusCode == 200) {
        Context.instance.delProduto();
        var count = 0;
        while (count <= lista.length) {
          itemProduto = lista[count];
          Context.instance.addProduto(Produto(
            id: itemProduto['pro_Id'],
            idcategoria: itemProduto['pro_IdCategoria'],
            nome: itemProduto['pro_Nome'],
            preco: double.parse(itemProduto['pro_Preco'].toString()),
            quant: 0,
            total: 0,
            unidade: itemProduto['pro_Unidade'],
            //valorfmt: '',
          ));

          count++;
          setStatusProduto('Atualizado ' +
              count.toString() +
              ' de ' +
              lista.length.toString());
        }
      } else {
        setStatusProduto('Erro ao buscar dados!');
      }
    });
  }

  Future<void> enviaPedidos() async {
    int count = 0;
    List _ped = await Context.instance.enviarPedido();
    //List _itens = await Context.instance.enviarItens();

    List<PedidoModel> vendaEnt = new List<PedidoModel>();

    for (Map map in _ped) {
      vendaEnt.add(PedidoModel.fromJson(map));
    }

    List _itens;
    for (PedidoModel item in vendaEnt) {
      _itens = await Context.instance.itensPedido(item.pedId);
      for (Map map in _itens) {
        item.pedidoItemModel.add(PedidoItemModel.fromJson(
            map)); //vendaEnt.add(PedidoModel.fromJson(item));
      }
    }

    for (PedidoModel item in vendaEnt) {
      VendasApi.postVendas(item).then((response) {
        print("Response status: ${response.statusCode}"); //200
        print(response.body.toString()); //Concluido
        if (response.statusCode == 200) {
          count++;
          Context.instance.alterarStatusPedido(item.pedId);
          setStatusVendas("Atualizado dados " +
              count.toString() +
              " de " +
              vendaEnt.length.toString());
        } else {
          setStatusVendas('Erro ao enviar os dados!');
        }
      });
      //data = DateTime.now().toString();
      //data = data.substring(0, 10);
      //item.venDataEnvio = data;
      //item.venDataEmissao = util.dataMySql(item.venDataEmissao);
      /*if (item.venNovoCliente == "S") {
        clienteRep.getCliente(int.parse(item.venCodCliente)).then((list) {
          item.clienteEntity = list;
          item.clienteEntity.cliCPFCNPJ =
              util.retirarMascara(item.clienteEntity.cliCPFCNPJ);
          item.clienteEntity.cliCep =
              util.retirarMascara(item.clienteEntity.cliCep);
        });
      }  */
      /*buscarItens(int.parse(item.venId)).then((list) {
        item.pedidoItensEntity = list;
        item.pedidoItensBrindesEntity = list;
        VendasApi.postVendas(item).then((response) {
          print("Response status: ${response.statusCode}"); //200
          print(response.body.toString()); //Concluido
          if (response.statusCode == 200) {
            count++;
            pedRep.alterarStatusPedido(item.venId);
            setStatusVendas("Atualizado dados " +
                count.toString() +
                " de " +
                vendaEnt.length.toString());
          } else {
            setStatusVendas('Erro ao enviar os dados!');
          }
        });
      }); */
    }

    /* if (_ped.length > 0) {
      String _jHeader = json.encode(_ped);
      var hEncodado = utf8.encode(_jHeader);
      var h = base64.encode(hEncodado);

      String _jItens = json.encode(_itens);
      var iEncodado = utf8.encode(_jItens);
      var i = base64.encode(iEncodado);

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {"pHeader": h, "pItens": i},
      );

      if (response.statusCode == 200) {
        if (response.body == '{"MESSAGE":"OK",  "RESULT":"OK"}') {
          Context.instance.delAllPedidos();
          Context.instance.delAllItem();
        }
      }
    } */
  }

/*  Future eviarVendas() async {
    var pedRep = new PedidoRepository();
    int count = 0;
    var data;
    List<PedidoEntity> vendaEnt = new List<PedidoEntity>();
    setStatusVendas('Enviando vendas!');
    await pedRep.getAllPedidoSincronizar().then((list) {
      vendaEnt = list;
      for (PedidoEntity item in vendaEnt) {
        data = DateTime.now().toString();
        data = data.substring(0, 10);
        item.venDataEnvio = data;
        item.venDataEmissao = util.dataMySql(item.venDataEmissao);
        if (item.venNovoCliente == "S") {
          clienteRep.getCliente(int.parse(item.venCodCliente)).then((list) {
            item.clienteEntity = list;
            item.clienteEntity.cliCPFCNPJ =
                util.retirarMascara(item.clienteEntity.cliCPFCNPJ);
            item.clienteEntity.cliCep =
                util.retirarMascara(item.clienteEntity.cliCep);
          });
        }
        buscarItens(int.parse(item.venId)).then((list) {
          item.pedidoItensEntity = list;
          item.pedidoItensBrindesEntity = list;
          VendasApi.postVendas(item).then((response) {
            print("Response status: ${response.statusCode}"); //200
            print(response.body.toString()); //Concluido
            if (response.statusCode == 200) {
              count++;
              pedRep.alterarStatusPedido(item.venId);
              setStatusVendas("Atualizado dados " +
                  count.toString() +
                  " de " +
                  vendaEnt.length.toString());
            } else {
              setStatusVendas('Erro ao enviar os dados!');
            }
          });
        });
      }
    });
  }  */

/*  Future<List<PedidoItensEntity>> buscarItens(int codPedido) async {
    var peditemRep = new PedidoItensRepository();
    List<PedidoItensEntity> itemEnt = new List<PedidoItensEntity>();
    await peditemRep.getAllPedidoItens(codPedido).then((list) {
      itemEnt = list;
    });
    return itemEnt;
  }  */
}
