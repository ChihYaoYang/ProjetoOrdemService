import 'package:flutter/material.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/tabbar_funcionario.dart';
import 'package:ordem_services/tabbar_cliente.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  int admin = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            accountName: Text('Nome do Usuário'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
            ),
          ),
          (admin == 0)
              ? ListTile(
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => TabBarMenu()));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (admin == 0)
              ? ListTile(
                  title: Text('Cadastrar Cliente'),
                  leading: Icon(
                    Icons.account_circle,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabBarCliente()));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (admin == 0)
              ? ListTile(
                  title: Text('Cadastrar Funcionários'),
                  leading: Icon(
                    Icons.supervisor_account,
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabBarFuncionario()));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (admin != 0)
              ? ListTile(
                  title: Text('Contato Suporte'),
                  leading: Icon(
                    Icons.comment,
                  ),
                  onTap: () {},
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          ListTile(
            title: Text('Dados do Usuário'),
            leading: Icon(
              Icons.verified_user,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text('Sair'),
            leading: Icon(
              Icons.exit_to_app,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}