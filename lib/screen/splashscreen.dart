import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/ui_cliente/home_cliente.dart';
import 'package:ordem_services/screen/login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 1)).then((_) async {
      //ex a getlogado / ex b status
      int a = 0;
      int admin = 1;
      if (a != 0) {
        if (admin == 1) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => TabBarMenu()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeCliente()));
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
