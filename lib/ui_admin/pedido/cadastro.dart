import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/cadastro_pedido_helper.dart';
import 'package:ordem_services/helper/cliente_helper.dart';
import 'package:ordem_services/helper/login_helper.dart';
import 'package:ordem_services/helper/status_helper.dart';
import 'package:ordem_services/helper/tipo_helper.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/utils/Dialogs.dart';
import 'package:ordem_services/utils/validator.dart';
import 'package:random_string/random_string.dart';
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
  LoginHelper helper = LoginHelper();
  Cadastro_Pedido pedido;
  Cadastro_Pedido _editedpedido;
  Cliente cliente;
  Cliente _editedcliente;
  bool isLoading = false;

  //DropDown
  String _dropdownError;
  List<Tipo> type = List();
  String _selectedtype;
  List<Status> status = List();
  String _selectedStatus;

  @override
  void initState() {
    super.initState();
    if (pedido == null || cliente == null) {
      _editedpedido = Cadastro_Pedido();
      _editedcliente = Cliente();
    } else {
      _editedpedido = Cadastro_Pedido.fromJson(pedido.toJson());
      _editedcliente = Cliente.fromJson(cliente.toJson());
      _nomeController.text = _editedcliente.nome;
      _emailController.text = _editedcliente.email;
      _telefoneController.text = _editedcliente.telefone;
      _cpfController.text = _editedcliente.cpf;
      _marcaController.text = _editedpedido.marca;
      _modeloController.text = _editedpedido.modelo;
      _defeitoController.text = _editedpedido.defeito;
      _descricaoController.text = _editedpedido.descricao;
    }
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
                              value: item.id.toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedtype = value;
                              _editedpedido.cd_tipo = _selectedtype;
                              _dropdownError = null;
                            });
                          },
                          value: _selectedtype,
                        ),
                      ),
              ),
              _dropdownError == null
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        _dropdownError ?? "",
                        style: TextStyle(color: Colors.red),
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
                              value: item.id.toString(),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedStatus = value;
                              _editedpedido.cd_status = _selectedStatus;
                              _dropdownError = null;
                            });
                          },
                          value: _selectedStatus,
                        ),
                      ),
              ),
              _dropdownError == null
                  ? SizedBox.shrink()
                  : Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        _dropdownError ?? "",
                        style: TextStyle(color: Colors.red),
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
              (isLoading)
                  ? new Align(
                      child: loadingIndicator,
                      alignment: FractionalOffset.center,
                    )
                  : RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text("Cadastrar"),
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          if (isEmail(_emailController.text)) {
                            if (isNumeric(_telefoneController.text)) {
                              if (CPFValidator.isValid(_cpfController.text)) {
                                _validateForm();
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
                              dialog.showAlertDialog(
                                  context, 'Aviso', 'Preencher somente número');
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
          ),
        ),
      ),
    );
  }

  _validateForm() async {
    bool _isValid = _formkey.currentState.validate();
    if (_selectedtype == null || _selectedStatus == null) {
      setState(() => _dropdownError = "Campo obrigatório !");
      _isValid = false;
    }
    if (_isValid) {
      //gerar senha aleatorio
      _editedcliente.password = randomAlphaNumeric(8);
      //cadastro
      await widget.api
          .cadastrarPedido(_editedcliente, _editedpedido, widget.login_id);
      final snackBar = SnackBar(
        duration: const Duration(minutes: 60),
        content: Text("Senha: " + _editedcliente.password),
        action: SnackBarAction(
          label: 'Copiar',
          onPressed: () async {
            Clipboard.setData(new ClipboardData(text: _editedcliente.password));
            Logado logado = await helper.getLogado();
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TabBarMenu(
                        logado.logado_login_id,
                        logado.nome,
                        logado.email,
                        logado.status,
                        Api(token: logado.token))));
          },
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
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
