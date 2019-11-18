import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../helper/Databases.dart';

class Item_PedidoHelper {
  static final Item_PedidoHelper _instance = Item_PedidoHelper.internal();

  factory Item_PedidoHelper() => _instance;

  Item_PedidoHelper.internal();

  Databases databases = new Databases();

  Future close() async {
    Database dbPerson = await databases.db;
    dbPerson.close();
  }
}

class Item_Pedido {
  dynamic id;
  dynamic cd_cadastro_pedido;
  dynamic cd_servicos;
  String servico;
  dynamic precos;

  Item_Pedido(
      {this.id,
      this.cd_cadastro_pedido,
      this.cd_servicos,
      this.servico,
      this.precos});

  factory Item_Pedido.fromJson(Map<String, dynamic> json) {
    return Item_Pedido(
        id: json['id'],
        cd_cadastro_pedido: json['cd_cadastro_pedido'],
        cd_servicos: json['cd_servicos'],
        servico: json['servico'],
        precos: json['precos']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cd_cadastro_pedido'] = this.cd_cadastro_pedido;
    data['cd_servicos'] = this.cd_servicos;
    data['servico'] = this.servico;
    data['precos'] = this.precos;
    return data;
  }

  @override
  String toString() {
    return "Item_Pedido(id: $id, cd_cadastro_pedido: $cd_cadastro_pedido, cd_servicos: $cd_servicos, servico: $servico, precos: $precos)";
  }
}
