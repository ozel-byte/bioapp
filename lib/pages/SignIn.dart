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
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerName,
              decoration: InputDecoration(hintText: "Correo"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerPassword,
              decoration: InputDecoration(hintText: "Contraseña"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            msjError,
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () async {
                final response = await capi.login(
                    _controllerName.text, _controllerPassword.text);

                if (response == "true") {
                  Navigator.pushNamed(context, "Menu");
                } else {
                  setState(() {
                    msjError = "Error de name o password";
                  });
                }
              },
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
}
