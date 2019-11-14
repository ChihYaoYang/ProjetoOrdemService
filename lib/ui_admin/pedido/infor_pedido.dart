import 'package:flutter/material.dart';

class Information_Pedido extends StatefulWidget {
  final dynamic id;
  final dynamic Cliente;
  final dynamic Tipo;
  final dynamic Status;
  final dynamic Funcionario;
  final String marca;
  final String modelo;
  final String defeito;
  final String descricao;
  final dynamic data_pedido;

  Information_Pedido(
      this.id,
      this.Cliente,
      this.Tipo,
      this.Status,
      this.Funcionario,
      this.marca,
      this.modelo,
      this.defeito,
      this.descricao,
      this.data_pedido);

  @override
  _Information_PedidoState createState() => _Information_PedidoState();
}

class _Information_PedidoState extends State<Information_Pedido> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.Cliente),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: GestureDetector(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Id: ' + widget.id.toString(),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Tipo: ' + widget.Tipo,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Status: ' + widget.Status,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Cadastrado por: ' + widget.Funcionario,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Marca: ' + widget.marca,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Modelo: ' + widget.modelo,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Defeito: ' + widget.defeito,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Descrição: ' + widget.descricao,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                            'Data foi cadastrado: ' + widget.data_pedido,
                            style: TextStyle(fontSize: 15.0)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
//      Center(
//        child: Padding(
//          padding: EdgeInsets.all(10.0),
//          child: Column(
//            children: <Widget>[
//              Text('Id' + widget.id.toString()),
//              Text('Tipo: ' + widget.Tipo),
//              Text('Status: ' + widget.Status),
//              Text('Cadastrado por: ' + widget.Funcionario),
//              Text('Marca: ' + widget.marca),
//              Text('Modelo: ' + widget.modelo),
//              Text('Defeito: ' + widget.defeito),
//              Text('Descrição: ' + widget.descricao),
//              Text('Data foi cadastrado: ' + widget.data_pedido),
//            ],
//          ),
//        ),
//      ),
    );
  }
}
