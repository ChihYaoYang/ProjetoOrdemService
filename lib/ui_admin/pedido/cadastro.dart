import 'package:flutter/material.dart';
import 'package:ordem_services/tabbar.dart';

class CadastroPedido extends StatefulWidget {
  @override
  _CadastroPedidoState createState() => _CadastroPedidoState();
}

class _CadastroPedidoState extends State<CadastroPedido> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _defeitoController = TextEditingController();
  final _descricaoController = TextEditingController();

  //DropDown
  List<String> _locations = ['Notebook', 'Celular'];
  String _selectedLocation;
  String _selectedStatus;
  List<String> _status = [
    'Em análise',
    'Aguardando análise',
    'Aguardando peça',
    'Pronto',
    'Sem solução'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Dados do Cliente",
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.45),
                    hintText: " Nome",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _nomeController,
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
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.45),
                    hintText: " E-mail",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _emailController,
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
                    hintText: " CPF",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.assignment_ind,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _cpfController,
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
                    hintText: " Telefone",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _telefoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório !";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(child: Divider(color: Colors.blueGrey)),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Dados do Pedido",
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.blueGrey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(
                      'Seleciona uma tipo',
                    ),
                    value: _selectedLocation,
                    onChanged: (value) {
                      setState(() {
                        _selectedLocation = value;
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.blueGrey)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text(
                      'Selecione status do pedido',
                    ),
                    value: _selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    },
                    items: _status.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.45),
                    hintText: " Marca",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.collections_bookmark,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _marcaController,
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
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.blueGrey.withOpacity(0.45),
                    hintText: " Modelo",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.mobile_screen_share,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _modeloController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório !";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                    hintText: " Defeito",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.report_problem,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _defeitoController,
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
                    hintText: " Descrição",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.text_fields,
                        color: Colors.white,
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  controller: _descricaoController,
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
                child: Text("Cadastrar"),
                color: Colors.blueGrey,
                textColor: Colors.white,
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    Navigator.pop(context);
//                    Navigator.pushReplacement(context,
//                        MaterialPageRoute(builder: (context) => TabBarMenu()));
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
