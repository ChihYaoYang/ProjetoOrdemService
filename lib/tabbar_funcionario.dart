import 'package:flutter/material.dart';
import 'package:ordem_services/utils/menu.dart';
import 'package:ordem_services/ui_admin/funcionario/cadastro.dart';
import 'package:ordem_services/ui_admin/funcionario/lista.dart';

class TabBarFuncionario extends StatefulWidget {
  dynamic status;

  TabBarFuncionario(this.status, {Key key}) : super(key: key);

  @override
  _TabBarFuncionarioState createState() => _TabBarFuncionarioState();
}

class _TabBarFuncionarioState extends State<TabBarFuncionario> {
  //目前選擇頁索引值 index(Página) atual
  int _currentIndex = 0; //預設值
  final pages = [ListaFuncionario(), CadastroFuncionario()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Funcionários'),
        centerTitle: true,
      ),
      body: pages[_currentIndex],
      drawer: DrawerMenu(widget.status),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text('Lista de Funcionário')),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), title: Text('Cadastrar Funcionário')),
        ],
        currentIndex: _currentIndex, //目前選擇頁索引值 index(Página) atual
        fixedColor: Colors.green, //選擇頁顏色
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
