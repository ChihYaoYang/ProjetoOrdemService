import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/utils/menu.dart';

class HomeCliente extends StatefulWidget {
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
      drawer: DrawerMenu(),
    );
  }
}
