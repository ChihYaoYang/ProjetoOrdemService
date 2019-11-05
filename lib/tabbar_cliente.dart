import 'package:flutter/material.dart';
import 'package:ordem_services/utils/menu.dart';
import 'package:ordem_services/ui_admin/cliente/cadastro.dart';
import 'package:ordem_services/ui_admin/cliente/lista.dart';

class TabBarCliente extends StatefulWidget {
  String nome;
  String email;
  dynamic status;

  TabBarCliente(this.nome, this.email, this.status, {Key key})
      : super(key: key);

  @override
  _TabBarClienteState createState() => _TabBarClienteState();
}

class _TabBarClienteState extends State<TabBarCliente> {
  //目前選擇頁索引值 index(Página) atual
  int _currentIndex = 0; //預設值
  final pages = [ListaCliente(), CadastroCliente()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Cliente'),
        centerTitle: true,
      ),
      body: pages[_currentIndex],
      drawer: DrawerMenu(widget.nome, widget.email, widget.status),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Lista de Cliente')),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), title: Text('Cadastrar Cliente')),
        ],
        currentIndex: _currentIndex, //目前選擇頁索引值 index(Página) atual
        fixedColor: Colors.deepPurple, //選擇頁顏色
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
