import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/cliente_helper.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:ordem_services/utils/connect.dart';

class Dados_User extends StatefulWidget {
  int login_id;
  String nome;
  String email;
  dynamic status;
  final Api api;

  Dados_User(this.login_id, this.nome, this.email, this.status, this.api);

  @override
  _Dados_UserState createState() => _Dados_UserState();
}

class _Dados_UserState extends State<Dados_User> {
  List<Cliente> cliente = List();
  Dialogs dialog = new Dialogs();
  Connect connect = new Connect();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    super.initState();
    isLoading = true;
    _getClientes();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = isLoading
        ? new Container(
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                  child: SpinKitDualRing(
                    color: Colors.blue,
                  ),
                )),
          )
        : new Container();
    return Scaffold(
        appBar: AppBar(
          title: Text("Dados de Cliente"),
          centerTitle: true,
        ),
        body: WillPopScope(
          child: (isLoading)
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
            )),
      ),
    );
  }

  _getClientes() async {
    connect.check().then((intenet) async {
      if (intenet != null && intenet) {
        print("connect");
        await widget.api.getClienteOne(widget.login_id.toString()).then((list) {
          setState(() {
            cliente = list;
            debugPrint(cliente.toString());
            isLoading = false;
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
        print("no connect");
        dialog.showAlertDialog(
            context, 'Aviso', 'Please check your connection and try again !');
      }
    });
  }
}
