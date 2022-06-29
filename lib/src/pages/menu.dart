import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Menu",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.pushNamed(context, "AgregarPaciente");
                  },
                  child: Text(
                    "Registrar Paciente",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.pushNamed(context, "Buscar");
                  },
                  child: Text(
                    "Buscar Paciente",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.pushNamed(context, "Bluetooth");
                  },
                  child: Text(
                    "Monitor",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
