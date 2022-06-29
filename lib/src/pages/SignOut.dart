import 'package:bioapp/src/services/ConexionApi.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Crear Cuenta"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: TextField(
              controller: _controllerName,
              decoration: InputDecoration(hintText: "name"),
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
