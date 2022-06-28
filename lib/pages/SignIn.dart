import 'package:bioapp/services/ConexionApi.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  ConexionApi capi = ConexionApi();
  String msjError = "";
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerName,
              onChanged: (v) {
                final _name = RegExp(r"[0-9]+");
                if (_name.hasMatch(v)) {
                  status = true;
                } else {
                  status = false;
                }
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
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                  hintText: "Contraseña", counterText: "Mínimo 5 caracteres"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            msjError,
            style: const TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      status ? Colors.grey : Colors.blue)),
              onPressed: !status || _controllerName.text.isNotEmpty
                  ? null
                  : iniciarSesion,
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                Navigator.pushNamed(context, "SignOut");
              },
              child: const Text(
                "Crear Cuenta",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }

  iniciarSesion() async {
    if (_controllerName.text.isNotEmpty &&
        _controllerPassword.text.isNotEmpty) {
      final response =
          await capi.login(_controllerName.text, _controllerPassword.text);
      if (response == "true") {
        Navigator.pushNamed(context, "Menu");
      } else {
        setState(() {
          msjError = "Error de name o password";
        });
      }
    }
  }
}
