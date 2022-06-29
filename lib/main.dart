import 'package:bioapp/src/pages/Buscar.dart';
import 'package:bioapp/src/pages/Monitor.dart';
import 'package:bioapp/src/pages/SignIn.dart';
import 'package:bioapp/src/pages/SignOut.dart';
import 'package:bioapp/src/pages/SplashScreen.dart';
import 'package:bioapp/src/pages/bluetooth.dart';
import 'package:bioapp/src/pages/menu.dart';
import 'package:bioapp/src/pages/registrarPaciente.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  runApp(MyApp());
}

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
        "Bluetooth": (_) => PageBlue(),
        "Monitor": (_) => Monitor()
      },
    );
  }
}
