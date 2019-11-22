import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:ordem_services/utils/Dialogs.dart';

class Connect extends State {
  Dialogs dialog = new Dialogs();

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
