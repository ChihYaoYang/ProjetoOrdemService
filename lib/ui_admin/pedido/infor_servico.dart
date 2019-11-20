import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/item_pedido_helper.dart';
import 'package:ordem_services/helper/servicos_helper.dart';
import 'package:ordem_services/ui_admin/pedido/updateservico.dart';

class Information_Servico extends StatefulWidget {
  final Api api;
  final dynamic id;
  final dynamic Cliente;

  Information_Servico(
    this.api,
    this.id,
    this.Cliente,
  );

  @override
  _Information_ServicoState createState() => _Information_ServicoState();
}

class _Information_ServicoState extends State<Information_Servico> {
  List<Item_Pedido> item = List();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    print(widget.id);
    _getItem();
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
      appBar: AppBar(
        title: Text(widget.Cliente),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: WillPopScope(
        child: (isLoading || item == null)
            ? new Align(
                child: loadingIndicator,
                alignment: FractionalOffset.center,
              )
            : ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return _itemCard(context, index);
                }),
      ),
    );
  }

  void _showContactPage({Item_Pedido item}) async {
    final recContact = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AlterarServico(item, widget.api)));
    if (recContact != null) {
      setState(() {
        isLoading = true;
      });
      if (item != null) {
        await widget.api.atualizarServicos(recContact);
      }
      _getItem();
    }
  }

  Widget _itemCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
          margin: new EdgeInsets.only(
              left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 5.0,
          child: ListTile(
            title: Text('Serviço feitos: ' + item[index].Servico,
                style: TextStyle(color: Colors.deepOrangeAccent)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text('Valor: ' + item[index].Precos,
                      style: TextStyle(color: Colors.indigoAccent)),
                ),
                Divider(),
                ButtonTheme.bar(
                  child: new ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        color: Colors.blue,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          _showContactPage(item: item[index]);
                        },
                      ),
                      FlatButton(
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                        color: Colors.deepPurple,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        textColor: Colors.white,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Aviso !'),
                                  content:
                                      Text('Você realmente deseja excluir ?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Sim'),
                                      onPressed: () {
                                        widget.api.deletarServico(
                                            item[index].cd_servicos);
                                        setState(() {
                                          item.removeAt(index);
                                          Navigator.pop(context);
                                        });
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
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _getItem() async {
    await widget.api.getItem(widget.id).then((list) {
      setState(() {
        isLoading = false;
        item = list;
//        debugPrint(item.toString());
      });
    });
  }
}
