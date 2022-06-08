import 'package:bioapp/services/ConexionApi.dart';
import 'package:flutter/material.dart';

class RegistrarPaciente extends StatefulWidget {
  RegistrarPaciente({Key? key}) : super(key: key);

  @override
  State<RegistrarPaciente> createState() => _RegistrarPacienteState();
}

class _RegistrarPacienteState extends State<RegistrarPaciente> {
  ConexionApi capi = ConexionApi();
  final TextEditingController _controllerNameVeterinario =
      TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerName2 = TextEditingController();
  final TextEditingController _controllerName3 = TextEditingController();
  final TextEditingController _controllerName4 = TextEditingController();
  final TextEditingController _controllerName5 = TextEditingController();
  final TextEditingController _controllerName6 = TextEditingController();
  final TextEditingController _controllerName7 = TextEditingController();
  final TextEditingController _controllerName8 = TextEditingController();
  final TextEditingController _controllerName9 = TextEditingController();
  final TextEditingController _controllerName10 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registro de paciente"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 60),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerNameVeterinario,
                    decoration: InputDecoration(
                        hintText: "Ingrese Nombre del veterinario"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName,
                    decoration: InputDecoration(
                        hintText: "Ingrese Nombre del la Mascota"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName2,
                    decoration: InputDecoration(
                        hintText: "Ingrese la edad de la Mascota"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName3,
                    decoration: InputDecoration(
                        hintText: "Ingrese el peso de la Mascota"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName4,
                    decoration: InputDecoration(
                        hintText: "Ingrese la raza de la mascota"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName5,
                    decoration: InputDecoration(
                        hintText: "Ingrese el sexo de la mascota"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName6,
                    decoration: InputDecoration(
                        hintText: "Ingrese la razon de ingreso"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName7,
                    decoration: InputDecoration(
                        hintText: "Ingrese el estado de ingreso"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName8,
                    decoration: InputDecoration(
                        hintText: "Ingrese el nombre del dueño"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName9,
                    decoration: InputDecoration(
                        hintText: "Ingrese el numero de contacto"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    controller: _controllerName10,
                    decoration:
                        InputDecoration(hintText: "Ingrese la direccion"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () async {
                      final response = await capi.registrarPaciente(
                          _controllerNameVeterinario.text,
                          _controllerName.text,
                          _controllerName2.text,
                          _controllerName3.text,
                          _controllerName4.text,
                          _controllerName5.text,
                          _controllerName6.text,
                          _controllerName7.text,
                          _controllerName8.text,
                          _controllerName9.text,
                          _controllerName10.text);
                      if (response == "true") {
                        Navigator.pushNamed(context, "Menu");
                      } else {
                        print("error");
                      }
                    },
                    child: Text("Registrar"))
              ],
            ),
          ],
        ));
  }
}
