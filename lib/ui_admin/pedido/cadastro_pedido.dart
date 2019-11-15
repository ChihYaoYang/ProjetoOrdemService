import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/cadastro_pedido_helper.dart';
import 'package:ordem_services/helper/cliente_helper.dart';
import 'package:ordem_services/helper/login_helper.dart';
import 'package:ordem_services/helper/status_helper.dart';
import 'package:ordem_services/helper/tipo_helper.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/utils/Dialogs.dart';

class CadasrarPedido extends StatefulWidget {
  final Api api;
  int login_id;

  CadasrarPedido(this.api, this.login_id);

  @override
  _CadasrarPedidoState createState() => _CadasrarPedidoState();
}

class _CadasrarPedidoState extends State<CadasrarPedido> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _defeitoController = TextEditingController();
  final _descricaoController = TextEditingController();
  Dialogs dialog = new Dialogs();
  LoginHelper helper = LoginHelper();
  Cadastro_Pedido pedido;
  Cadastro_Pedido _editedpedido;
  bool isLoading = false;
  bool _userEdited = false;

  //DropDown
  String _dropdownError;
  List<Cliente> client = List();
  String _selectedClient;
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
    _getAllClientes();
    if (pedido == null) {
      _editedpedido = Cadastro_Pedido();
    } else {
      _editedpedido = Cadastro_Pedido.fromJson(pedido.toJson());
      _marcaController.text = _editedpedido.marca;
      _modeloController.text = _editedpedido.modelo;
      _defeitoController.text = _editedpedido.defeito;
      _descricaoController.text = _editedpedido.descricao;
    }
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
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Cadasrar Pedido'),
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
                    "Cliente",
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: Colors.blueGrey)),
                  child: (isLoading || client == null)
                      ? new Align(
                          child: loadingIndicator,
                          alignment: FractionalOffset.center,
                        )
                      : DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text(
                              'Seleciona o Cliente',
                            ),
                            items: client?.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item.email.toString()),
                                    value: item.id.toString(),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _userEdited = true;
                                _selectedClient = value;
                                _editedpedido.cd_cliente = _selectedClient;
                                _dropdownError = null;
                              });
                            },
                            value: _selectedClient,
                          ),
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
                  child: (isLoading || type == null)
                      ? new Align(
                          child: loadingIndicator,
                          alignment: FractionalOffset.center,
                        )
                      : DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text(
                              'Seleciona uma tipo',
                            ),
                            items: type?.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item.type.toString()),
                                    value: item.id.toString(),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _userEdited = true;
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
                  child: (isLoading || status == null)
                      ? new Align(
                          child: loadingIndicator,
                          alignment: FractionalOffset.center,
                        )
                      : DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text(
                              'Selecione status do pedido',
                            ),
                            items: status?.map((item) {
                                  return new DropdownMenuItem(
                                    child: Text(item.status.toString()),
                                    value: item.id.toString(),
                                  );
                                }).toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _userEdited = true;
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
                    onChanged: (text) {
                      _userEdited = true;
                      _editedpedido.marca = text;
                    },
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
                    onChanged: (text) {
                      _userEdited = true;
                      _editedpedido.modelo = text;
                    },
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
                    onChanged: (text) {
                      _userEdited = true;
                      _editedpedido.defeito = text;
                    },
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
                    onChanged: (text) {
                      _userEdited = true;
                      _editedpedido.descricao = text;
                    },
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
                            _validateForm();
                          }
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateForm() async {
    bool _isValid = _formkey.currentState.validate();
    if (_selectedClient == null ||
        _selectedtype == null ||
        _selectedStatus == null) {
      setState(() => _dropdownError = "Campo obrigatório !");
      _isValid = false;
    }
    if (_isValid) {
      //cadastro
      await widget.api.cadastrarPedido(_editedpedido, widget.login_id);
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
    }
  }

  _getAllType() async {
    await widget.api.getType().then((list) {
      setState(() {
        isLoading = false;
        type = list;
        debugPrint(type.toString());
      });
    });
  }

  _getAllStatus() async {
    await widget.api.getStatus().then((list) {
      setState(() {
        isLoading = false;
        status = list;
        debugPrint(status.toString());
      });
    });
  }

  _getAllClientes() async {
    await widget.api.getCliente().then((list) {
      setState(() {
        isLoading = false;
        client = list;
        debugPrint(client.toString());
      });
    });
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Descartar alterações?'),
              content: Text('Se sair as alterações serão perdidas.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Sim'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}