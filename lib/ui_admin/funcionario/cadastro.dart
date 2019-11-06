import 'package:flutter/material.dart';
import 'package:ordem_services/ui_admin/funcionario/lista.dart';

class CadastroFuncionario extends StatefulWidget {
  @override
  _CadastroFuncionarioState createState() => _CadastroFuncionarioState();
}

class _CadastroFuncionarioState extends State<CadastroFuncionario> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
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
                      hintText: " Endereço: R. B.",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Container(
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                        color: Colors.blue,
                      ),
                    ),
                    controller: _enderecoController,
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
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  child: Text("Cadastrar"),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      Navigator.pop(context);
//                      Navigator.pushReplacement(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => ListaFuncionario()));
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
