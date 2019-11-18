import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/helper/item_pedido_helper.dart';

class Information_Servico extends StatefulWidget {
  final Api api;
  final dynamic id;
  final dynamic Cliente;

  Information_Servico(this.api, this.id, this.Cliente);

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

  Widget _itemCard(BuildContext context, int index) {
    return Container(
      height: 1000,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blue, Colors.greenAccent])),
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Card(
                margin: new EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 5.0,
                child: ListTile(
                  title: Text(
                    'Id: ' + widget.id.toString(),
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child:
                            Text('cadastro: ' + item[index].cd_cadastro_pedido),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'servico: ' + item[index].cd_servicos,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  _getItem() async {
    await widget.api.getItem(widget.id).then((list) {
      setState(() {
        isLoading = false;
        item = list;
        debugPrint(item.toString());
      });
    });
  }
}
