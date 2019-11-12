import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/status_helper.dart';
import 'package:ordem_services/helper/tipo_helper.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:ordem_services/utils/validator.dart';
import 'package:validators/validators.dart';

class CadastroPedido extends StatefulWidget {
  final Api api;
  int login_id;

  CadastroPedido(this.api, this.login_id);

  @override
  _CadastroPedidoState createState() => _CadastroPedidoState();
}

class _CadastroPedidoState extends State<CadastroPedido> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = MaskedTextController(mask: '000.000.000-00');
  final _telefoneController = TextEditingController();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _defeitoController = TextEditingController();
  final _descricaoController = TextEditingController();
  Dialogs dialog = new Dialogs();
  bool isLoading = false;

  //DropDown
  List<Tipo> type = List();
  String _selectedtype;
  List<Status> status = List();
  String _selectedStatus;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getAllType();
    _getAllStatus();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = isLoading
        ? new Container(
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(
                    child: new LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ))),
          )
        : new Container();
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
                child: (isLoading)
                    ? new Align(
                        child: loadingIndicator,
                        alignment: FractionalOffset.center,
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            'Seleciona uma tipo',
                          ),
                          items: type.map((item) {
                            return new DropdownMenuItem(
                              child: Text(item.type.toString()),
                              value: item.toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedtype = value;
                            });
                          },
                          value: _selectedtype,
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
                child: (isLoading)
                    ? new Align(
                        child: loadingIndicator,
                        alignment: FractionalOffset.center,
                      )
                    : DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(
                            'Selecione status do pedido',
                          ),
                          items: status.map((item) {
                            return new DropdownMenuItem(
                              child: Text(item.status.toString()),
                              value: item.toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                          value: _selectedStatus,
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
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    if (isEmail(_emailController.text)) {
                      if (isNumeric(_telefoneController.text)) {
                        if (CPFValidator.isValid(_cpfController.text)) {
                          //gerar senha aleatorio
//                                _editedFuncionario.password =
//                                    randomAlphaNumeric(8);
                          //cadastro
//                                await api
//                                    .cadastrarFuncionario(_editedFuncionario);
//                                final snackBar = SnackBar(
//                                  duration: const Duration(minutes: 60),
//                                  content: Text(
//                                      "Senha: " + _editedFuncionario.password),
//                                  action: SnackBarAction(
//                                    label: 'Copiar',
//                                    onPressed: () async {
//                                      Clipboard.setData(new ClipboardData(
//                                          text: _editedFuncionario.password));
//                                      Logado logado = await helper.getLogado();
//                                      Navigator.pop(context);
//                                      Navigator.pushReplacement(
//                                          context,
//                                          MaterialPageRoute(
//                                              builder: (context) =>
//                                                  TabBarFuncionario(
//                                                      logado.logado_login_id,
//                                                      logado.nome,
//                                                      logado.email,
//                                                      logado.status,
//                                                      Api(
//                                                          token:
//                                                              logado.token))));
//                                    },
//                                  ),
//                                );
//                                Scaffold.of(context).showSnackBar(snackBar);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          dialog.showAlertDialog(
                              context, 'Aviso', 'Preencher com CPF válido');
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        dialog.showAlertDialog(
                            context, 'Aviso', 'Preencher somente número');
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                      });
                      dialog.showAlertDialog(
                          context, 'Aviso', 'Preencher com E-mail válido');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getAllType() async {
    widget.api.getType().then((list) {
      setState(() {
        isLoading = false;
        type = list;
        debugPrint(type.toString());
      });
    });
  }

  _getAllStatus() async {
    widget.api.getStatus().then((list) {
      setState(() {
        isLoading = false;
        status = list;
        debugPrint(status.toString());
      });
    });
  }
}
