import 'dart:core';
import 'package:flutter/material.dart';

class Dialogs extends State {
  void showBottomOptions(BuildContext context, botoes) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: botoes),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
