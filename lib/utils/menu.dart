import 'package:flutter/material.dart';
import 'package:ordem_services/ui_admin/cadastro.dart';
import 'package:ordem_services/tabbar.dart';

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
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
            ),
          ),
          (admin != 0)
              ? ListTile(
                  title: Text('Cadastrar Cliente'),
                  leading: Icon(
                    Icons.account_circle,
                  ),
                  onTap: () {},
                )
              : Visibility(
                  visible: true,
                  child: Text(''),
                ),
          ListTile(
            title: Text('Contato Suporte'),
            leading: Icon(
              Icons.comment,
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
