import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/screen/login.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/tabbar_funcionario.dart';
import 'package:ordem_services/tabbar_cliente.dart';
import 'package:ordem_services/helper/login_helper.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  LoginHelper helperLog = LoginHelper();

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
          (widget != null)
              ? ListTile(
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home,
                  ),
                  onTap: () {
//                    Navigator.pushReplacement(context,
//                        MaterialPageRoute(builder: (context) => TabBarMenu()));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (widget != null)
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
          (widget == null)
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
            onTap: () async {
              await helperLog.deleteLogado();
              Navigator.pop(context);
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
