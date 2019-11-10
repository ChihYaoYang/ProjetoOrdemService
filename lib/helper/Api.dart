import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ordem_services/helper/login_helper.dart';

import 'cliente_helper.dart';
import 'funcionario_helper.dart';

const BASE_URL = "http://ordemservice.epizy.com/rest/";

class Api {
  String token;

  Api({this.token});

  Future<Login> login(String email, String senha) async {
    http.Response response = await http.post(BASE_URL + "Login/login",
        body: jsonEncode({"password": senha, "email": email}),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print(response.body);
      Login dadosJson = new Login.fromMap(json.decode(response.body));
      return dadosJson;
    } else {
      return null;
    }
  }

  Future<List<Funcionario>> getfuncionario() async {
    http.Response response = await http.get(BASE_URL + 'Funcionario',
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List<Funcionario> funcionarios =
          json.decode(response.body).map<Funcionario>((map) {
        return Funcionario.fromJson(map);
      }).toList();
      return funcionarios;
    } else {
      return null;
    }
  }

  Future<Funcionario> cadastrarFuncionario(Funcionario funcionario) async {
    http.Response response = await http.post(BASE_URL + "Login/cadastro",
        body: jsonEncode({
          "nome": funcionario.nome,
          "email": funcionario.email,
          "password": funcionario.password,
          "telefone": funcionario.telefone,
          "cpf": funcionario.cpf
        }),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      Funcionario dadosJson =
          new Funcionario.fromJson(json.decode(response.body));
      return dadosJson;
    } else {
      return null;
    }
  }

  Future<bool> deletarFuncionario(String codigoFuncionario) async {
    http.Response response = await http.delete(
        BASE_URL + "Funcionario/" + codigoFuncionario,
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Funcionario> atualizarFuncionario(Funcionario funcionario) async {
    http.Response response =
        await http.put(BASE_URL + "Funcionario/" + funcionario.id,
            body: jsonEncode({
              "nome": funcionario.nome,
              "email": funcionario.email,
              "password": funcionario.password,
              "telefone": funcionario.telefone,
              "cpf": funcionario.cpf
            }),
            headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return new Funcionario.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  ///////////////////////////////////Cliente//////////////////////////////////////////////
  Future<List<Cliente>> getCliente() async {
    http.Response response = await http.get(BASE_URL + 'Cliente',
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      List<Cliente> clientes = json.decode(response.body).map<Cliente>((map) {
        return Cliente.fromJson(map);
      }).toList();
      return clientes;
    } else {
      return null;
    }
  }

  Future<bool> deletarCliente(String codigoFuncionario) async {
    http.Response response = await http.delete(
        BASE_URL + "Cliente/" + codigoFuncionario,
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<Cliente> atualizarCliente(Cliente cliente) async {
    http.Response response = await http.put(BASE_URL + "Cliente/" + cliente.id,
        body: jsonEncode({
          "nome": cliente.nome,
          "email": cliente.email,
          "password": cliente.password,
          "telefone": cliente.telefone,
          "cpf": cliente.cpf
        }),
        headers: {'token': token, 'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return new Cliente.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
}
