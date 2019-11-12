import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class CadastrarServicos extends StatefulWidget {
  @override
  _CadastrarServicosState createState() => _CadastrarServicosState();
}

class _CadastrarServicosState extends State<CadastrarServicos> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _servicesController = TextEditingController();
  final _precosController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Cadastrar Serviços'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Serviço feitos",
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Divider(color: Colors.blueGrey)),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  maxLines: 5,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.45),
                    hintText: " Descrição dos Servicos",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.room_service,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _servicesController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório !";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.45),
                    hintText: " Preço",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.attach_money,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _precosController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório !";
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Text("Cadastrar Serviço"),
                color: Colors.blueGrey,
                textColor: Colors.white,
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
