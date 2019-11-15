import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/ui_admin/pedido/cadastro_pedido.dart';
import 'package:ordem_services/ui_admin/pedido/home.dart';
import 'package:ordem_services/ui_admin/pedido/cadastro_new_pedido.dart';
import 'package:ordem_services/helper/Api.dart';

class TabBarMenu extends StatefulWidget {
  final Api api;
  int login_id;
  String nome;
  String email;
  dynamic status;

  TabBarMenu(this.login_id, this.nome, this.email, this.status, this.api,
      {Key key})
      : super(key: key);

  @override
  _TabBarMenuState createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu> {
  int _currentIndex = 0; //預設值
  List<Widget> pages() => [
        HomePage(widget.api, widget.login_id, widget.nome, widget.email,
            widget.status),
        CadastroPedido(widget.api, widget.login_id, widget.nome, widget.email,
            widget.status),
      ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> page = pages();
    return Scaffold(
      body: page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Lista de Pedido')),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), title: Text('New Pedido')),
        ],
        currentIndex: _currentIndex, //目前選擇頁索引值 index(Página) atual
        fixedColor: Colors.amber, //選擇頁顏色
        onTap: (int index) {
          //BottomNavigationBar 按下處理事件，更新設定當下索引值
          setState(() {
            _currentIndex = index;
          });
        }, //BottomNavigationBar 按下處理事件
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (page[0] == page[_currentIndex])
          ? FloatingActionButton.extended(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              label: Text(
                'Pedido',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(
                Icons.event_note,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CadasrarPedido(widget.api, widget.login_id)));
              },
            )
          : Container(),
    );
  }
}
