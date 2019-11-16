import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/cadastro_pedido_helper.dart';
import 'package:ordem_services/helper/tipo_helper.dart';
import 'package:ordem_services/ui_admin/pedido/update.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:ordem_services/ui_admin/pedido/cadastrar_servicos.dart';
import 'package:ordem_services/utils/menu.dart';

import 'infor_pedido.dart';

class HomePage extends StatefulWidget {
  final Api api;
  int login_id;
  String nome;
  String email;
  dynamic status;

  HomePage(this.api, this.login_id, this.nome, this.email, this.status);

  @override
  _HomePageState createState() => _HomePageState();
}

enum OrderOptions {
  show_all,
  em_analise,
  aguard_analise,
  aguard_peca,
  entrega,
  sem_solucao
}

class _HomePageState extends State<HomePage> {
  List<Cadastro_Pedido> pedido = List();
  List<Tipo> type = List();
  Dialogs dialog = new Dialogs();
  bool isLoading = false;

  List<Cadastro_Pedido> _queryResults = [];
  List<Cadastro_Pedido> _filter = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getAllPedidos();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = isLoading
        ? new Container(
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();
    return Scaffold(
      appBar: AppBar(
        title: Text('OS'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<OrderOptions>(
              icon: Icon(Icons.arrow_drop_down),
              itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                    const PopupMenuItem<OrderOptions>(
                      child: Text('Show All'),
                      value: OrderOptions.show_all,
                    ),
                    const PopupMenuItem<OrderOptions>(
                      child: Text('Em Análise'),
                      value: OrderOptions.em_analise,
                    ),
                    const PopupMenuItem<OrderOptions>(
                      child: Text('Aguardando Análise'),
                      value: OrderOptions.aguard_analise,
                    ),
                    const PopupMenuItem<OrderOptions>(
                      child: Text('Aguardando Peça'),
                      value: OrderOptions.aguard_peca,
                    ),
                    const PopupMenuItem<OrderOptions>(
                      child: Text('Pronto à Entrega'),
                      value: OrderOptions.entrega,
                    ),
                    const PopupMenuItem<OrderOptions>(
                      child: Text('Sem Solução'),
                      value: OrderOptions.sem_solucao,
                    ),
                  ],
              onSelected: _orderList)
        ],
      ),
      drawer: DrawerMenu(widget.nome, widget.email, widget.status),
      body: WillPopScope(
        child: (isLoading || pedido == null)
            ? new Align(
                child: loadingIndicator,
                alignment: FractionalOffset.center,
              )
            : ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: pedido.length,
                itemBuilder: (context, index) {
                  return _itemCard(context, index);
                }),
      ),
    );
  }

  Widget _itemCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Cliente: ' + pedido[index].Cliente,
                  overflow: TextOverflow.ellipsis),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Divider(),
                  Text('Tipo: ' + pedido[index].Tipo,
                      overflow: TextOverflow.ellipsis),
                  Text('Status: ' + pedido[index].Status,
                      overflow: TextOverflow.ellipsis),
                  Text('Defeito: ' + pedido[index].defeito,
                      overflow: TextOverflow.ellipsis),
                  Text('Data: ' + pedido[index].data_pedido,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: Text((index + 1).toString()),
            )),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    List<Widget> botoes = [];
    botoes.add(FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.visibility, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Visualizar',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Information_Pedido(
                    pedido[index].id,
                    pedido[index].Cliente,
                    pedido[index].Tipo,
                    pedido[index].Status,
                    pedido[index].Funcionario,
                    pedido[index].marca,
                    pedido[index].modelo,
                    pedido[index].defeito,
                    pedido[index].descricao,
                    pedido[index].data_pedido,
                  )),
        );
      },
    ));
    botoes.add(FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.edit, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Cadastrar Serviço',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CadastrarServicos()));
      },
    ));
    botoes.add(FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.edit, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Serviço',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {},
    ));
    botoes.add(FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.edit, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Pedido',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
//        Navigator.pop(context);
//        Navigator.push(
//            context, MaterialPageRoute(builder: (context) => AlterarPedido()));
      },
    ));

    botoes.add(FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.delete, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Deletar',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Aviso !'),
                content: Text('Você realmente deseja excluir ?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Sim'),
                    onPressed: () {
                      widget.api.deletarPedido(pedido[index].id);
                      setState(() {
                        Navigator.pop(context);
                        pedido.removeAt(index);
                        Navigator.pop(context);
                      });
                    },
                  ),
                  FlatButton(
                    child: Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
    ));
    dialog.showBottomOptions(context, botoes);
  }

  _getAllPedidos() async {
    widget.api.getPedido().then((list) {
      setState(() {
        isLoading = false;
        pedido = list;
        _filter = list;
      });
    });
  }

  void _orderList(OrderOptions result) async {
    switch (result) {
      case OrderOptions.show_all:
        _queryResults = _filter;
        break;
      case OrderOptions.em_analise:
        _queryResults = _filter
            .where((status) => status.Status.contains('Em análise'))
            .toList();
        break;
      case OrderOptions.aguard_analise:
        _queryResults = _filter
            .where((status) => status.Status.contains('Aguardando análise'))
            .toList();
        break;
      case OrderOptions.aguard_peca:
        _queryResults = _filter
            .where((status) => status.Status.contains('Aguardando peça'))
            .toList();
        break;
      case OrderOptions.entrega:
        _queryResults = _filter
            .where((status) => status.Status.contains('Pronto a entrega'))
            .toList();
        break;
      case OrderOptions.sem_solucao:
        _queryResults = _filter
            .where((status) => status.Status.contains('Sem solução'))
            .toList();
        break;
    }
    pedido = _queryResults;
    setState(() {});
  }
}
