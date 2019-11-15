import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/cliente_helper.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:ordem_services/utils/menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ordem_services/ui_admin/cliente/alterar.dart';

class ListaCliente extends StatefulWidget {
  final Api api;
  int login_id;
  String nome;
  String email;
  dynamic status;

  ListaCliente(this.api, this.login_id, this.nome, this.email, this.status);

  @override
  _ListaClienteState createState() => _ListaClienteState();
}

class _ListaClienteState extends State<ListaCliente> {
  List<Cliente> cliente = List();
  Dialogs dialog = new Dialogs();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getAllClientes();
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
          backgroundColor: Colors.blueAccent,
          title: Text('Lista de Cliente'),
          centerTitle: true,
        ),
        drawer: DrawerMenu(widget.nome, widget.email, widget.status),
        body: WillPopScope(
          child: (isLoading || cliente == null)
              ? new Align(
                  child: loadingIndicator,
                  alignment: FractionalOffset.center,
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: cliente.length,
                  itemBuilder: (context, index) {
                    return _clienteCard(context, index);
                  }),
        ));
  }

  Widget _clienteCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Nome: ' + cliente[index].nome,
                  overflow: TextOverflow.ellipsis),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('E-mail: ' + cliente[index].email,
                      overflow: TextOverflow.ellipsis),
                  Text('Telefone: ' + cliente[index].telefone,
                      overflow: TextOverflow.ellipsis),
                  Text('CPF: ' + cliente[index].cpf,
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

  void _Alterar({Cliente cliente}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdateCliente(
                  client: cliente,
                )));
    if (recContact != null) {
      setState(() {
        isLoading = true;
      });
      if (cliente != null) {
        await widget.api.atualizarCliente(recContact);
      }
      _getAllClientes();
    }
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
        launch("tel:${cliente[index].telefone}");
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
        launch("mailto:${cliente[index].email}?subject=Olá&body=Tudo bem ?");
        Navigator.pop(context);
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
                    'Alterar',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),
                  )
                ],
              ))
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
        _Alterar(cliente: cliente[index]);
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
                      widget.api.deletarCliente(cliente[index].id);
                      setState(() {
                        Navigator.pop(context);
                        cliente.removeAt(index);
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

  _getAllClientes() async {
    widget.api.getCliente().then((list) {
      setState(() {
        isLoading = false;
        cliente = list;
        debugPrint(cliente.toString());
      });
    });
  }
}
