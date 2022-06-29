import 'package:flutter/material.dart';

class Monitor extends StatefulWidget {
  Monitor({Key? key}) : super(key: key);

  @override
  State<Monitor> createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monitor"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ECG:",
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {},
                  child:
                      Text("Visualizar", style: TextStyle(color: Colors.white)))
            ],
          ),
          Row(
            children: [Text("Frecuencia cardiaca: ")],
          ),
          Row(
            children: [Text("Frecuencia respiratoria: ")],
          )
        ],
      ),
    );
  }
}
