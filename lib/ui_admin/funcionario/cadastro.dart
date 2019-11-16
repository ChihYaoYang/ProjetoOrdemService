import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/funcionario_helper.dart';
import 'package:ordem_services/helper/login_helper.dart';
import 'package:ordem_services/utils/validator.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:validators/validators.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';
import 'package:ordem_services/tabbar_funcionario.dart';

class CadastroFuncionario extends StatefulWidget {
  @override
  _CadastroFuncionarioState createState() => _CadastroFuncionarioState();
}

class _CadastroFuncionarioState extends State<CadastroFuncionario> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  LoginHelper helper = LoginHelper();
  Dialogs dialog = new Dialogs();
  Api api = new Api();
  Funcionario funcionario;
  Funcionario _editedFuncionario;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (funcionario == null) {
      _editedFuncionario = Funcionario();
    } else {
      _editedFuncionario = Funcionario.fromJson(funcionario.toJson());
      _nomeController.text = _editedFuncionario.nome;
      _emailController.text = _editedFuncionario.email;
      _telefoneController.text = _editedFuncionario.telefone;
      _cpfController.text = _editedFuncionario.cpf;
    }
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
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ))),
          )
        : new Container();
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(60),
                    ],
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
                    onChanged: (text) {
                      _editedFuncionario.nome = text;
                    },
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
                    onChanged: (text) {
                      _editedFuncionario.email = text;
                    },
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
                    inputFormatters: [
                      new LengthLimitingTextInputFormatter(20),
                    ],
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
                    onChanged: (text) {
                      _editedFuncionario.telefone = text;
                    },
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
                    onChanged: (text) {
                      _editedFuncionario.cpf = text;
                    },
                    controller: _cpfController,
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
                (isLoading)
                    ? new Align(
                        child: loadingIndicator,
                        alignment: FractionalOffset.center,
                      )
                    : RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.transparent)),
                        child: Text("Cadastrar"),
                        color: Colors.blueGrey,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            if (isEmail(_emailController.text)) {
                              if (isNumeric(_telefoneController.text)) {
                                if (CPFValidator.isValid(_cpfController.text)) {
                                  _editedFuncionario.password =
                                      randomAlphaNumeric(8);
                                  //cadastro
                                  await api
                                      .cadastrarFuncionario(_editedFuncionario);
                                  final snackBar = SnackBar(
                                    duration: const Duration(minutes: 60),
                                    content: Text("Senha: " +
                                        _editedFuncionario.password),
                                    action: SnackBarAction(
                                      label: 'Copiar',
                                      onPressed: () async {
                                        Clipboard.setData(new ClipboardData(
                                            text: _editedFuncionario.password));
                                        Logado logado =
                                            await helper.getLogado();
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabBarFuncionario(
                                                        logado.logado_login_id,
                                                        logado.nome,
                                                        logado.email,
                                                        logado.status,
                                                        Api(
                                                            token: logado
                                                                .token))));
                                      },
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  dialog.showAlertDialog(context, 'Aviso',
                                      'Preencher com CPF válido');
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                dialog.showAlertDialog(context, 'Aviso',
                                    'Preencher somente número');
                              }
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              dialog.showAlertDialog(context, 'Aviso',
                                  'Preencher com E-mail válido');
                            }
                          }
                        },
                      ),
              ],
            )),
      ),
    );
  }
}
