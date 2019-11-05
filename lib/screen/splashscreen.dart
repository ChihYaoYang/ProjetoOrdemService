import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/ui_cliente/home_cliente.dart';
import 'package:ordem_services/screen/login.dart';
import 'package:ordem_services/helper/login_helper.dart';
import 'package:ordem_services/helper/Api.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  LoginHelper helper = LoginHelper();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 1)).then((_) async {
      Logado logado = await helper.getLogado();
      if (logado != null) {
        if (logado.status == 1) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TabBarMenu(logado.id, logado.nome,
                      logado.email, logado.status, Api(token: logado.token))));
        } else if (logado.status == 2) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeCliente(
                      logado.id, logado.nome, logado.email, logado.status)));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: Container(
            width: 150,
            height: 150,
            child: Image.asset("assets/ic_launcher.png"),
          ),
        ));
  }
}
