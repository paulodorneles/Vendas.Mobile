import 'package:pedidos/src/repository/cliente_repository.dart';
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
import 'package:pedidos/src/controller/usuario_controller.dart';

import 'dart:convert';
import 'package:mobx/mobx.dart';

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

  var clienteRep = new ClienteRepository();
  var tipoRep = new TipoEnvioMercadoriaRepository();
  var grupoRep = new GrupoRepository();
  var produtoRep = new ProdutoRepository();
  var formaRep = new FormaPagtoRepository();
  var condRep = new CondPagtoRepository();
  var controllerUsu = new UsuarioController();

  var util = new Util();

  Future<void> sincronizarDados(
      bool cliente, bool produto, bool tabelas) async {
    if (cliente) {
      buscarCliente();
    }
    if (produto) {
      buscarProduto();
    }
    if (tabelas) {
      buscarTabelas();
    }
  }

  @action
  void buscarTabelas() {
    buscarCondPagamento();
    buscarFormaPagamento();
    buscarGrupo();
    buscarParametros();
    buscarTipoEnvioMercadoria();
  }

  void buscarGrupo() {
    setStatusCondPagto('Buscando Grupo');
    GrupoApi.getGrupo().then((response) {
      final lista = json.decode(response.body);
      var grupo = new List<GrupoEntity>(lista.length);
      var itemGrupo;

      grupoRep.getNumber().then((value) {
        grupoRep.deleteAl();
        var count = 0;
        while (count <= lista.length) {
          itemGrupo = lista[count];
          grupo[count] = new GrupoEntity();
          grupo[count].gruId = itemGrupo['gru_Id'];
          grupo[count].gruDescricao = itemGrupo['gru_Descricao'];
          grupo[count].gruOrdem = itemGrupo['gru_Ordem'];
          grupo[count].gruReg = itemGrupo['gru_Reg'];
          grupo[count].gruResumo = itemGrupo['gru_Resumo'];
          grupoRep.saveGrupo(grupo[count]);
          count++;
          setStatusCondPagto('Atualizado ' +
              count.toString() +
              ' de ' +
              lista.length.toString());
        }
      });
    });
  }

  void buscarTipoEnvioMercadoria() {
    setStatusCondPagto('Buscando Tipo Envio Merc.');
    double teste;
    TipoEnvioMercadoriaApi.getTipoEnvioMercadoria().then((response) {
      final lista = json.decode(response.body);
      var tipoenvio = new List<TipoEnvioMercadoriaEntity>(lista.length);
      var itemTipo;

      tipoRep.getNumber().then((value) {
        tipoRep.deleteAl();
        var count = 0;
        while (count <= lista.length) {
          itemTipo = lista[count];
          tipoenvio[count] = new TipoEnvioMercadoriaEntity();
          tipoenvio[count].temCodigo = itemTipo['tem_Codigo'];
          tipoenvio[count].temDescricao = itemTipo['tem_Descricao'];
          teste = double.parse(itemTipo['tem_Valor'].toString());
          tipoenvio[count].temValor = teste;
          tipoRep.saveTipoEnvioMercadoria(tipoenvio[count]);
          count++;
          setStatusCondPagto('Atualizado ' +
              count.toString() +
              ' de ' +
              lista.length.toString());
        }
      });
    });
  }

  void buscarParametros() {
    setStatusCondPagto('Buscando Parâmetros');
    ParametrosApi.getParametros().then((response) {
      final lista = json.decode(response.body);
      var parametros = new List<ParametrosEntity>(lista.length);
      var itemParametro;
      // grupoRep.deleteAl();
      var count = 0;
      while (count <= lista.length) {
        itemParametro = lista[count];
        parametros[count] = new ParametrosEntity();
        parametros[count].parMaxValorDescPermitido =
            itemParametro['par_MaxValorDescPermitido'];
        double teste = double.parse(
            itemParametro['par_ValorMinimoPecaParaDesconto'].toString());

        parametros[count].parValorMinimoPecaParaDesconto = teste;

        //  tipoRep.saveTipoEnvioMercadoria(tipoenvio[count]);

        controllerUsu.valorMaximoPerDesconto =
            parametros[count].parMaxValorDescPermitido;
        controllerUsu.valorMinimoProdutoDesconto =
            parametros[count].parValorMinimoPecaParaDesconto;

        controllerUsu.gravarArqIni();

        count++;
        setStatusCondPagto('Atualizado ' +
            count.toString() +
            ' de ' +
            lista.length.toString());
      }
    });
  }

  @action
  void buscarCliente() {
    var cliente;
    setStatusCliente('Buscando clientes');
    var idUsuario = controllerUsu.idUsuario.toString();
    ClienteApi.getClientes(idUsuario).then((response) {
      final lista = json.decode(response.body);

      if (response.statusCode == 200) {
        var cliente = new List<ClienteEntity>(lista.length);
        var itemCliente;

        clienteRep.getNumber().then((value) {
          clienteRep.deleteAl();
          var count = 0;
          while (count <= lista.length) {
            itemCliente = lista[count];
            cliente[count] = new ClienteEntity();
            cliente[count].cliId = itemCliente['cli_Id'];
            cliente[count].cliNome = itemCliente['cli_Nome'];
            cliente[count].cliNFantasia = itemCliente['cli_NFantasia'];
            cliente[count].cliNComprador = itemCliente['cli_NComprador'];
            cliente[count].cliContato = itemCliente['cli_Contato'];
            cliente[count].cliIESUFRAMA = itemCliente['cli_IESUFRAMA'];
            cliente[count].cliTipoPessoa = itemCliente['cli_TipoPessoa'];
            cliente[count].cliCPFCNPJ = itemCliente['cli_CPFCNPJ'];
            cliente[count].cliInscEstadual = itemCliente['cli_InscEstadual'];
            cliente[count].cliLogradouro = itemCliente['cli_Logradouro'];
            cliente[count].cliComplemento = itemCliente['cli_Complemento'];
            cliente[count].cliCodCidade = itemCliente['cli_CodCidade'];
            cliente[count].cliCep = itemCliente['cli_Cep'];
            cliente[count].cliEmail = itemCliente['cli_Email'];
            cliente[count].cliDDD1 = itemCliente['cli_DDD1'];
            cliente[count].cliFone1 = itemCliente['cli_Fone1'];
            cliente[count].cliDDD2 = itemCliente['cli_DDD2'];
            cliente[count].cliFone2 = itemCliente['cli_Fone2'];
            cliente[count].cliSituacao = "1";
            // cliente[count].cliObservacao = itemCliente['cli_Observacao'];
            cliente[count].cliHomologadoCecop =
                itemCliente['cli_HomologadoCecop'];
            cliente[count].cliIdVendedor = itemCliente['cli_IdVendedor'];
            cliente[count].cliDescCidade = itemCliente['cli_DescCidade'];
            cliente[count].cliDescUF = itemCliente['cli_UF'];

            clienteRep.save(cliente[count]);
            count++;
            setStatusCliente('Atualizado ' +
                count.toString() +
                ' de ' +
                lista.length.toString());
          }
        });
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
      var produto = new List<ProdutoEntity>(lista.length);
      var itemProduto;
      //String teste;

      if (response.statusCode == 200) {
        produtoRep.getNumber().then((value) {
          produtoRep.deleteAl();
          var count = 0;
          while (count <= lista.length) {
            itemProduto = lista[count];
            produto[count] = new ProdutoEntity();
            //teste = itemProduto['pro_Referencia'].toString();
            produto[count].proReferencia =
                itemProduto['pro_Referencia'].toString();
            produto[count].proTipo = itemProduto['pro_Tipo'];
            produto[count].proDescricao1 = itemProduto['pro_Descricao1'];
            //  teste = itemProduto['pro_Descricao2'];
            produto[count].proDescricao2 = itemProduto['pro_Descricao2'];
            produto[count].proDescricao3 = itemProduto['pro_Descricao3'];
            produto[count].proCodGrupo = itemProduto['pro_CodGrupo'];
            produto[count].proNGrupo = itemProduto['pro_NGrupo'];
            produto[count].proCodSubGrupo = itemProduto['pro_CodSubGrupo'];
            produto[count].proNSubGrupo = itemProduto['pro_NSubGrupo'];
            produto[count].proUnidadeMedida = itemProduto['pro_UnidadeMedida'];
            produto[count].proVlr1 =
                double.parse(itemProduto['pro_Vlr1'].toString());
            produto[count].proVlr2 =
                double.parse(itemProduto['pro_Vlr2'].toString());
            produto[count].proVlr3 =
                double.parse(itemProduto['pro_Vlr3'].toString());
            produto[count].proVlr4 =
                double.parse(itemProduto['pro_Vlr4'].toString());
            produto[count].proVlr5 =
                double.parse(itemProduto['pro_Vlr5'].toString());
            produto[count].proVlr6 =
                double.parse(itemProduto['pro_Vlr6'].toString());
            produto[count].proVlrTotalAux = 0;
            produto[count].proVlrProdDescontoAux = 0;
            produto[count].proPercDescProdAux = 0;
            produto[count].proVlrVenda = 0;
            produto[count].proSituacao = itemProduto['pro_Situacao'];
            produto[count].proPromocao = itemProduto['pro_Promocao'];
            produto[count].proId = itemProduto['pro_Id'];
            produto[count].proQtdeEstoque = itemProduto['pro_QtdeEstoque'];

            produtoRep.saveProduto(produto[count]);
            count++;
            setStatusProduto('Atualizado ' +
                count.toString() +
                ' de ' +
                lista.length.toString());
          }
        });
      } else {
        setStatusProduto('Erro ao buscar dados!');
      }
    });
  }

  void buscarFormaPagamento() {
    setStatusCondPagto('Buscando Cond. Pagto');
    FormaPagtoApi.getFormaPagto().then((response) {
      final lista = json.decode(response.body);
      var formapgto = new List<FormaPagtoEntity>(lista.length);
      var itemForma;

      formaRep.getNumber().then((value) {
        formaRep.deleteAl();
        var count = 0;
        while (count <= lista.length) {
          itemForma = lista[count];
          formapgto[count] = new FormaPagtoEntity();
          formapgto[count].fopCodigo = itemForma['fop_Codigo'];
          formapgto[count].fopDescricao = itemForma['fop_Descricao'];

          formaRep.saveFormaPagto(formapgto[count]);
          count++;
          setStatusCondPagto('Atualizado ' +
              count.toString() +
              ' de ' +
              lista.length.toString());
        }
      });
    });
  }

  void buscarCondPagamento() {
    CondPagtoApi.getCondPagto().then((response) {
      final lista = json.decode(response.body);
      var condpgto = new List<CondPagtoEntity>(lista.length);
      var itemCond;

      condRep.getNumber().then((value) {
        condRep.deleteAl();
        var count = 0;
        while (count <= lista.length) {
          itemCond = lista[count];
          condpgto[count] = new CondPagtoEntity();
          condpgto[count].copId = itemCond['cop_Id'];
          condpgto[count].copDescricao = itemCond['cop_Descricao'];

          condRep.saveCondPagto(condpgto[count]);
          count++;
        }
      });
    });
  }

  Future eviarVendas() async {
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
          buscarItensBrinde(int.parse(item.venId)).then((list) {
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
        });
      }
    });
  }

  Future<List<PedidoItensEntity>> buscarItens(int codPedido) async {
    var peditemRep = new PedidoItensRepository();
    List<PedidoItensEntity> itemEnt = new List<PedidoItensEntity>();
    await peditemRep.getAllPedidoItens(codPedido).then((list) {
      itemEnt = list;
    });
    return itemEnt;
  }

  Future<List<PedidoItensBrindesEntity>> buscarItensBrinde(
      int codPedido) async {
    var peditembrindeRep = new PedidoItensBrindeRepository();
    List<PedidoItensBrindesEntity> itemEnt =
        new List<PedidoItensBrindesEntity>();
    await peditembrindeRep.getAllPedidoItensBrinde(codPedido).then((list) {
      itemEnt = list;
    });
    return itemEnt;
  }

/*  _enviarVendas() {
    PedidoEntity vendaEnt = new PedidoEntity();
    PedidoItensEntity vendaItensEnt = new PedidoItensEntity();

    vendaEnt.venCodCliente = '2';
    vendaEnt.venId = '8';
    vendaEnt.venIdRepresentante = 20;
    vendaEnt.venDataEmissao = "2021-05-20T08:50:25";
    vendaEnt.venDataEnvio = "2021-05-20T08:50:38";
    vendaEnt.venNovoCliente = "N";
    vendaEnt.venQtdePecas = 20;
    vendaEnt.venStatus = 1;
    vendaEnt.venTotalProdutos = 20;
    vendaEnt.venValorDesconto = 0;
    vendaEnt.venValorFrete = 20;
    vendaEnt.venValorTotalPedido = 20;
    vendaItensEnt = _buscarItens();
    vendaEnt.pedidoItensEntity = new List<PedidoItensEntity>();
    vendaEnt.pedidoItensEntity.add(vendaItensEnt);
    VendasApi.postVendas(vendaEnt).then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.contentLength}");
      print(response.headers);
      print(response.request);
      final lista = json.decode(response.body);
      statusProduto = "Atualizando dados ... ";
    });
  }

  PedidoItensEntity _buscarItens() {
    PedidoItensEntity vendaItensEnt = new PedidoItensEntity();
    vendaItensEnt.veiIdVendas = '8';
    vendaItensEnt.veiItem = 1;
    vendaItensEnt.veiObservacao = null;
    vendaItensEnt.veiPercDesc = 1;
    vendaItensEnt.veiQtde = 20;
    vendaItensEnt.veiReferencia = "7010C4";
    vendaItensEnt.veiValorDesc = 1;
    vendaItensEnt.veiValorOriginal = 1;
    vendaItensEnt.veiValorTotal = 20;
    vendaItensEnt.veiVelorUnitario = 1;
    return vendaItensEnt;
  }  */
}
