import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/funcionario_helper.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaFuncionario extends StatefulWidget {
  final Api api;
  int login_id;

  ListaFuncionario(this.api, this.login_id);

  @override
  _ListaFuncionarioState createState() => _ListaFuncionarioState();
}

class _ListaFuncionarioState extends State<ListaFuncionario> {
  List<Funcionario> funcionario = List();
  Dialogs dialog = new Dialogs();
  Api api = new Api();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getAllFuncionarios();
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
            child: (isLoading)
                ? new Align(
                    child: loadingIndicator,
                    alignment: FractionalOffset.center,
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: funcionario.length,
                    itemBuilder: (context, index) {
                      return _funcionarioCard(context, index);
                    }),
            onWillPop: () {
              return null;
            }));
  }

  Widget _funcionarioCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Nome: ' + funcionario[index].nome),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('E-mail: ' + funcionario[index].email),
                  Text('Número: ' + funcionario[index].telefone),
                  Text('CPF: ' + funcionario[index].cpf),
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
          Icon(Icons.phone_in_talk, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Ligar',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
        launch("tel:${funcionario[index].telefone}");
        Navigator.pop(context);
      },
    ));
    botoes.add(FlatButton(
      child: Row(
        children: <Widget>[
          Icon(Icons.email, color: Colors.blueAccent),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Enviar e-mail',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
        launch(
            "mailto:${funcionario[index].email}?subject=Olá&body=Tudo bem ?");
        Navigator.pop(context);
      },
    ));
//    botoes.add(FlatButton(
//      child: Row(
//        children: <Widget>[
//          Icon(Icons.edit, color: Colors.blueAccent),
//          Padding(
//              padding: EdgeInsets.only(left: 10),
//              child: Column(
//                children: <Widget>[
//                  Text(
//                    'Modificar',
//                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
//                  )
//                ],
//              ))
//        ],
//      ),
//      onPressed: () {},
//    ));
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
                      Navigator.pop(context);
                      Navigator.pop(context);
                      api.deletarFuncionario(funcionario[index].id);
                      setState(() {
                        funcionario.removeAt(index);
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

  _getAllFuncionarios() async {
    widget.api.getfuncionario().then((list) {
      setState(() {
        isLoading = false;
        funcionario = list;
        debugPrint(funcionario.toString());
      });
    });
  }
}
