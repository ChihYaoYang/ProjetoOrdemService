import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/ui_admin/pedido/home.dart';
import 'package:ordem_services/ui_admin/pedido/cadastro.dart';
import 'package:ordem_services/utils/menu.dart';

class TabBarMenu extends StatefulWidget {
  TabBarMenu({Key key}) : super(key: key);

  @override
  _TabBarMenuState createState() => _TabBarMenuState();
}

enum OrderOptions {
  em_analise,
  aguard_analise,
  aguard_peca,
  entrega,
  sem_solucao
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
        actions: <Widget>[
          (pages[0] == pages[_currentIndex])
              ? PopupMenuButton<OrderOptions>(
                  icon: Icon(Icons.arrow_drop_down),
                  itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
                        const PopupMenuItem<OrderOptions>(
                          child: Text('Em Análise'),
                          value: OrderOptions.em_analise,
                        ),
                        const PopupMenuItem<OrderOptions>(
                          child: Text('Aguardando Análise'),
                          value: OrderOptions.aguard_analise,
                        ),
                        const PopupMenuItem<OrderOptions>(
                          child: Text('Aguardando Peça'),
                          value: OrderOptions.aguard_peca,
                        ),
                        const PopupMenuItem<OrderOptions>(
                          child: Text('Pronto à Entrega'),
                          value: OrderOptions.entrega,
                        ),
                        const PopupMenuItem<OrderOptions>(
                          child: Text('Sem Solução'),
                          value: OrderOptions.sem_solucao,
                        ),
                      ],
                  onSelected: _orderList)
              : Container(),
        ],
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

  void _orderList(OrderOptions result) async {
    switch (result) {
      case OrderOptions.em_analise:
        // TODO: Handle this case.
        break;
      case OrderOptions.aguard_analise:
        // TODO: Handle this case.
        break;
      case OrderOptions.aguard_peca:
        // TODO: Handle this case.
        break;
      case OrderOptions.entrega:
        // TODO: Handle this case.
        break;
      case OrderOptions.sem_solucao:
        // TODO: Handle this case.
        break;
    }
    setState(() {});
  }
}
