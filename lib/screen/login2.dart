import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/login_helper.dart';
import 'package:ordem_services/ui_cliente/home_cliente.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'dart:io';
import '../tabbar.dart';

class LoginPage2 extends StatefulWidget {
  final Login login;
  final Api api;

  LoginPage2({this.login, this.api});

  @override
  _LoginPage2State createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool isLoading = false;

  LoginHelper helper = LoginHelper();
  Api api = new Api();
  List<Login> login = List();
  Dialogs dialog = new Dialogs();

  @override
  void initState() {
    super.initState();
  }

  void check() async {
    setState(() async {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
        }
      } on SocketException catch (_) {
        print("no connection ");
        dialog.showAlertDialog(
            context, 'Aviso', 'Please check your connection internet !');
        setState(() {
          isLoading = false;
        });
      }
    });
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
                    child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ))),
          )
        : new Container();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    filled: true,
                    fillColor: Colors.red.withOpacity(0.25),
                    hintText: " Digite seu Telefone",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Container(
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      color: Colors.redAccent,
                    ),
                  ),
                  controller: _phoneController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Campo obrigatório !";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  (isLoading)
                      ? new Align(
                          child: loadingIndicator,
                          alignment: FractionalOffset.center,
                        )
                      : RaisedButton(
                          padding: EdgeInsets.all(10),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              side: BorderSide(color: Colors.transparent)),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          color: Colors.red,
                          textColor: Colors.white,
                          onPressed: () async {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            if (_formkey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              //check connection
                              check();
                              Login user =
                                  await api.loginPhone(_phoneController.text);
                              if (user != null) {
                                helper.saveLogado(user.id, user.nome,
                                    user.email, user.status, user.token);
                                Logado logado = await helper.getLogado();
                                if (logado.status == 1) {
                                  Navigator.pop(context);
                                  await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabBarMenu(
                                              user.id,
                                              user.nome,
                                              user.email,
                                              user.status,
                                              Api(token: user.token))));
                                } else if (logado.status == 2) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeCliente(
                                              user.id,
                                              user.nome,
                                              user.email,
                                              user.status)));
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                dialog.showAlertDialog(
                                    context, 'Aviso', 'Login inválido');
                              }
                            }
                          },
                        )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
