import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/ui_admin/home.dart';
import 'package:ordem_services/ui_admin/cadastro.dart';
import 'package:ordem_services/utils/menu.dart';

class TabBarMenu extends StatefulWidget {
  TabBarMenu({Key key}) : super(key: key);

  @override
  _TabBarMenuState createState() => _TabBarMenuState();
}

class _TabBarMenuState extends State<TabBarMenu> {
  //目前選擇頁索引值 index(Página) atual
  int _currentIndex = 0; //預設值
  final pages = [HomePage(), CadastroPedido()];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OS'),
        centerTitle: true,
      ),
      body: pages[_currentIndex],
      drawer: DrawerMenu(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Lista de Pedido')),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), title: Text('Cadastrar Pedido')),
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
    );
  }
}
