import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../helper/Databases.dart';

class Cadastro_PedidoHelper {
  static final Cadastro_PedidoHelper _instance =
      Cadastro_PedidoHelper.internal();

  factory Cadastro_PedidoHelper() => _instance;

  Cadastro_PedidoHelper.internal();

  Databases databases = new Databases();

  Future close() async {
    Database dbPerson = await databases.db;
    dbPerson.close();
  }
}

class Cadastro_Pedido {
  dynamic id;
  dynamic cd_cliente;
  dynamic cd_tipo;
  dynamic cd_status;
  dynamic cd_funcionario;
  String marca;
  String modelo;
  String defeito;
  String descricao;

  Cadastro_Pedido(
      {this.id,
      this.cd_cliente,
      this.cd_tipo,
      this.cd_status,
      this.cd_funcionario,
      this.marca,
      this.modelo,
      this.defeito,
      this.descricao});

  factory Cadastro_Pedido.fromJson(Map<String, dynamic> json) {
    return Cadastro_Pedido(
        id: json['id'],
        cd_cliente: json['cd_cliente'],
        cd_tipo: json['cd_tipo'],
        cd_status: json['cd_status'],
        cd_funcionario: json['cd_funcionario'],
        marca: json['marca'],
        modelo: json['modelo'],
        defeito: json['defeito'],
        descricao: json['descricao']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cd_cliente'] = this.cd_cliente;
    data['cd_tipo'] = this.cd_tipo;
    data['cd_status'] = this.cd_status;
    data['cd_funcionario'] = this.cd_funcionario;
    data['marca'] = this.marca;
    data['modelo'] = this.modelo;
    data['defeito'] = this.defeito;
    data['descricao'] = this.descricao;
    return data;
  }

  @override
  String toString() {
    return "Cadastro_Pedido(id: $id, cd_cliente: $cd_cliente, cd_tipo: $cd_tipo, cd_status: $cd_status, cd_funcionario: $cd_funcionario, marca: $marca, modelo: $modelo, defeito: $defeito, descricao: $descricao)";
  }
}
