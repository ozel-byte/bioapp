import 'package:bioapp/src/services/ConexionApi.dart';
import 'package:bioapp/src/state/validForm.dart';
import 'package:flutter/material.dart';

class SignOunt extends StatefulWidget {
  SignOunt({Key? key}) : super(key: key);

  @override
  State<SignOunt> createState() => _SignOuntState();
}

class _SignOuntState extends State<SignOunt> {
  ConexionApi capi = ConexionApi();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Crear Cuenta",
            style: TextStyle(fontSize: 30),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerName,
              key: Key("nombre"),
              onChanged: (v) {
                status = ValidForm().validNombre(v);
                setState(() {});
              },
              decoration: InputDecoration(
                  hintText: "Nombre",
                  counterText: "No puede contener signos o números",
                  counterStyle:
                      TextStyle(color: !status ? Colors.grey : Colors.red)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                  hintText: "Contraseña", counterText: "Mínimo 5 caracteres"),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () async {
                final response = await capi.crearCuenta(
                    _controllerName.text, _controllerPassword.text);
                print(response);
                if (response == "true") {
                  Navigator.pushNamed(context, "Menu");
                } else {
                  print("error");
                }
              },
              child: const Text(
                "crear cuenta",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
