import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/utils/menu.dart';

class HomeCliente extends StatefulWidget {
  int login_id;
  String nome;
  String email;
  dynamic status;

  HomeCliente(this.login_id, this.nome, this.email, this.status);

  @override
  _HomeClienteState createState() => _HomeClienteState();
}

class _HomeClienteState extends State<HomeCliente> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Pedido"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      drawer: DrawerMenu(widget.nome, widget.email, widget.status),
    );
  }
}
