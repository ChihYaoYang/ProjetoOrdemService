import 'package:flutter/material.dart';
import 'package:ordem_services/helper/funcionario_helper.dart';
import 'package:ordem_services/ui_admin/funcionario/cadastro.dart';
import 'package:ordem_services/ui_admin/funcionario/lista.dart';

import 'helper/Api.dart';

class TabBarFuncionario extends StatefulWidget {
  final Api api;
  int login_id;
  String nome;
  String email;
  dynamic status;

  TabBarFuncionario(this.login_id, this.nome, this.email, this.status, this.api,
      {Key key})
      : super(key: key);

  @override
  _TabBarFuncionarioState createState() => _TabBarFuncionarioState();
}

class _TabBarFuncionarioState extends State<TabBarFuncionario> {
  FuncionarioHelper helper = FuncionarioHelper();

  //目前選擇頁索引值 index(Página) atual
  int _currentIndex = 0; //預設值
  List<Widget> pages() => [
        ListaFuncionario(widget.api, widget.login_id, widget.nome, widget.email,
            widget.status),
        CadastroFuncionario(widget.nome, widget.email, widget.status),
      ];

  @override
  void initState() {
    super.initState();
    print(widget.api);
    print(widget.login_id);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> page = pages();
    return Scaffold(
      body: page[_currentIndex],
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
