import 'package:bioapp/pages/Buscar.dart';
import 'package:bioapp/pages/SignIn.dart';
import 'package:bioapp/pages/SignOut.dart';
import 'package:bioapp/pages/SplashScreen.dart';
import 'package:bioapp/pages/bluetooth.dart';
import 'package:bioapp/pages/menu.dart';
import 'package:bioapp/pages/registrarPaciente.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: {
        "/": (_) => SplashScreen(),
        "SignIn": (_) => SignIn(),
        "SignOut": (_) => SignOunt(),
        "Menu": (_) => Menu(),
        "AgregarPaciente": (_) => RegistrarPaciente(),
        "Buscar": (_) => SearchPaciente(),
        "Bluetooth": (_) => PageBlue()
      },
    );
  }
}
