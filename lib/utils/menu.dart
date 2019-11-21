import 'package:flutter/material.dart';
import 'package:ordem_services/helper/Api.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/tabbar_funcionario.dart';
import 'package:ordem_services/helper/login_helper.dart';
import 'package:ordem_services/tabbar_login.dart';
import 'package:ordem_services/ui_admin/cliente/lista.dart';

class DrawerMenu extends StatefulWidget {
  String nome;
  String email;
  dynamic status;

  DrawerMenu(this.nome, this.email, this.status);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  LoginHelper helperLog = LoginHelper();

  @override
  void initState() {
    super.initState();
  }

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
            accountName: Text(widget.nome),
            accountEmail: Text(widget.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'),
            ),
          ),
          (widget.status == "1" || widget.status == 1)
              ? ListTile(
                  title: Text('Home'),
                  leading: Icon(
                    Icons.home,
                  ),
                  onTap: () async {
                    Logado logado = await helperLog.getLogado();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabBarMenu(
                                logado.id,
                                logado.nome,
                                logado.email,
                                logado.status,
                                Api(token: logado.token))));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (widget.status == "1" || widget.status == 1)
              ? ListTile(
                  title: Text('Lista de Cliente'),
                  leading: Icon(
                    Icons.supervisor_account,
                  ),
                  onTap: () async {
                    Logado logado = await helperLog.getLogado();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListaCliente(
                                Api(token: logado.token),
                                logado.id,
                                logado.nome,
                                logado.email,
                                logado.status)));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (widget.status == "1" || widget.status == 1)
              ? ListTile(
                  title: Text('Cadastrar de Funcionários'),
                  leading: Icon(
                    Icons.supervisor_account,
                  ),
                  onTap: () async {
                    Logado logado = await helperLog.getLogado();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabBarFuncionario(
                                logado.id,
                                logado.nome,
                                logado.email,
                                logado.status,
                                Api(token: logado.token))));
                  },
                )
              : Visibility(
                  visible: true,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 0),
                  ),
                ),
          (widget.status == "2" || widget.status == 2)
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
          (widget.status == "2" || widget.status == 2)
              ? ListTile(
                  title: Text('Dados do Usuário'),
                  leading: Icon(
                    Icons.verified_user,
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
          Divider(),
          ListTile(
            title: Text('Sair'),
            leading: Icon(
              Icons.exit_to_app,
            ),
            onTap: () async {
              await helperLog.deleteLogado();
              Navigator.pop(context);
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TabBarLogin()));
            },
          ),
        ],
      ),
    );
  }
}
