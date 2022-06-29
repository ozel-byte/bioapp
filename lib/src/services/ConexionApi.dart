import 'dart:convert';
import 'package:bioapp/src/model/Paciente.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ConexionApi {
  ConexionApi();

  Future<String> login(name, password) async {
    final url = Uri.parse(
        "http://192.168.0.44:5000/login?name=$name&password=$password");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json_response = jsonDecode(response.body);
      if (json_response["status"] == true) {
        return json_response["status"].toString();
      } else {
        return json_response["status"].toString();
      }
    } else {
      return "no se pudo";
    }
  }

  Future<List<Paciente>> busqueda(palabra) async {
    List<Paciente> pacienteList = [];
    final url = Uri.parse("http://192.168.0.44:5000/busqueda");
    final response =
        await http.post(url, body: jsonEncode({"palabra": palabra}));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["status"] == "true") {
        print(jsonResponse["value"][0][1]["nombreMascota"]);
        for (var item in jsonResponse["value"]) {
          print(item[1]["nombreMascota"]);
          Paciente p = Paciente(
              nombreMascota: item[1]["nombreMascota"],
              nombreVeterinario: item[1]["nombrePaciente"],
              contacto: item[1]["numeroContacto"],
              direccion: item[1]["direccion"],
              edad: item[1]["edadMascota"],
              estado: item[1]["estadoMascota"],
              nombreDueno: item[1]["nombreDueño"],
              peso: item[1]["pesoMascota"],
              raza: item[1]["razaMascota"],
              razon: item[1]["razonMascota"],
              sexo: item[1]["sexoMascota"]);
          pacienteList.add(p);
        }
        return pacienteList;
      } else {
        return jsonResponse["status"];
      }
    } else {
      return [];
    }
  }

  Future<String> crearCuenta(name, password) async {
    final url = Uri.parse("http://192.168.0.44:5000/add-user");
    final response = await http.post(url,
        body: jsonEncode({"name": name, "password": password}));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse["status"] == "true") {
        return jsonResponse["status"].toString();
      } else {
        return jsonResponse["status"].toString();
      }
    } else {
      return "no se pudo";
    }
  }

  Future<String> registrarPaciente(
      nV, nM, eM, pM, rM, sM, raM, esM, nD, nC, d) async {
    final url = Uri.parse("http://192.168.0.44:5000/add-paciente");
    final response = await http.post(url,
        body: jsonEncode({
          "id": const Uuid().v4(),
          "nombre-veterinario": nV,
          "nombre-mascota": nM,
          "edad-mascota": eM,
          "peso-mascota": pM,
          "raza-mascota": rM,
          "sexo-mascota": sM,
          "razon-mascota": raM,
          "estado-mascota": esM,
          "nombre-dueño": nD,
          "numero-contacto": nC,
          "direccion": d
        }));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse["status"] == "true") {
        return jsonResponse["status"].toString();
      } else {
        return jsonResponse["status"].toString();
      }
    } else {
      return "error";
    }
  }
}
