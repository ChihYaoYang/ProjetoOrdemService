import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordem_services/tabbar.dart';
import 'package:ordem_services/ui_cliente/home_cliente.dart';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  int a = 0;
  runApp(MaterialApp(
    home: (a == 0) ? TabBarMenu() : HomeCliente(),
    debugShowCheckedModeBanner: false,
  ));
}
