import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/cadastro_pedido_helper.dart';
import 'package:ordem_services/helper/tipo_helper.dart';
import 'package:ordem_services/ui_admin/pedido/cadastro.dart';
import 'package:ordem_services/ui_admin/pedido/update.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:ordem_services/ui_admin/pedido/cadastrar_servicos.dart';

import 'infor_pedido.dart';

class HomePage extends StatefulWidget {
  final Api api;
  int login_id;

  HomePage(this.api, this.login_id);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Cadastro_Pedido> pedido = List();
  List<Tipo> type = List();
  Dialogs dialog = new Dialogs();
  bool isLoading = false;

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
    ));
  }

  Widget _itemCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Nome do Cliente: ' + pedido[index].Cliente),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('Tipo: ' + pedido[index].Tipo),
                  Text('Status: ' + pedido[index].Status),
                  Text('Cadastrado por: ' + pedido[index].Funcionario),
                  Text('Defeito: ' + pedido[index].defeito),
                  Text('Data Cadastrado: ' + pedido[index].data_pedido),
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
//        showDialog(
//            context: context,
//            builder: (context) {
//              return AlertDialog(
//                title: Text('Aviso !'),
//                content: Text('Você realmente deseja excluir ?'),
//                actions: <Widget>[
//                  FlatButton(
//                    child: Text('Sim'),
//                    onPressed: () {
//                      Navigator.pop(context);
//                      Navigator.pop(context);
//                    },
//                  ),
//                  FlatButton(
//                    child: Text('Cancelar'),
//                    onPressed: () {
//                      Navigator.pop(context);
//                      Navigator.pop(context);
//                    },
//                  )
//                ],
//              );
//            });
      },
    ));
    dialog.showBottomOptions(context, botoes);
  }

  _getAllPedidos() async {
    widget.api.getPedido().then((list) {
      setState(() {
        isLoading = false;
        pedido = list;
        debugPrint(pedido.toString());
      });
    });
  }
}
