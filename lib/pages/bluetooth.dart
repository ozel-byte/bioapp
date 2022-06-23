import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'dart:typed_data';
import 'package:bioapp/services/graficaStream.dart';
import 'package:bioapp/widgest/grafica.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PageBlue extends StatefulWidget {
  const PageBlue({Key? key}) : super(key: key);

  @override
  State<PageBlue> createState() => _PageBlueState();
}

class _PageBlueState extends State<PageBlue> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  FlutterBluetoothSerial _bluetoothSerial = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _deviceList = [];
  GraficaStream gs = GraficaStream();
  String bpm = "";
  String ecg = "";
  String ts = "0.0";
  String spo2 = "0";
  bool temcolor = false;
  bool status2 = false;
  String ins = "";
  String pam = "";
  bool st = false;
  var connection;

  bool get isConnected => connection != null && connection.isConnected;

  var _deviceState;
  var _device;
  bool _isButtonUnavaible = false;
  String vozText = "";
  int posicionListActiveConected = 0;
  bool activeSenal = false;
  bool activeConnectNone = false;
  String nombreDispositivoConectado = "";
  String direcionDispositivoConectado = "";
  String status = "...";
  String fr = "0";
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0;

    enabledBluetooth();

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        getPairedDevices();
      });
    });
  }

  Future<bool> enabledBluetooth() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();

      return true;
    } else {
      await getPairedDevices();
    }

    return false;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await _bluetoothSerial.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _deviceList = devices;
    });
  }

  bool isDisconnecting = false;

  bool _connected = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              FlutterBluetoothSerial.instance.requestDisable();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          "Encender bluetooth",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Switch(
              activeColor: Colors.blue,
              value: _bluetoothState.isEnabled,
              onChanged: (bool value) {
                future() async {
                  if (value) {
                    await FlutterBluetoothSerial.instance.requestEnable();
                  } else {
                    await FlutterBluetoothSerial.instance.requestDisable();
                  }

                  await getPairedDevices();
                  _isButtonUnavaible = false;

                  if (_connected) {
                    _disconnec();
                  }
                }

                future().then((_) => {setState(() {})});
              }),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                  width: size.width * 1,
                  height: size.height * 0.08,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Lista de dispositivos",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 30),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Divider(),
              SizedBox(
                width: size.width * 1,
                height: size.height * 0.4,
                child: listDeviceActive(size),
              ),
              Divider(),
              SizedBox(
                width: size.width * 1,
                height: size.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("FR: $fr",
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 30)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.accessibility_sharp)
                      ],
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 2000),
                      curve: Curves.easeOutQuad,
                      child: Text("ECG: " + ecg,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.thermostat_auto_sharp,
                          color:
                              double.parse(ts) > 37 ? Colors.red : Colors.blue,
                        ),
                        Text(
                          "Temperatura: " + ts,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: double.parse(ts) > 37
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: Duration(seconds: 3),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Icon(
                            Icons.favorite_outlined,
                            color: Colors.red,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "BPM: " + bpm,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_queue,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Saturacion-oxigeno: " + spo2,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: int.parse(spo2) == -85
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PAM: " + pam,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: int.parse(spo2) == -85
                                  ? Colors.red
                                  : Colors.blue),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Indice de shock: " + ins,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          status2 == false
              ? Container()
              : Positioned(
                  bottom: size.height / 2.5,
                  child: Container(
                    width: size.width,
                    height: size.height * 0.4,
                    color: Colors.white,
                    child: SimpleLineChart.withSampleData(
                        gs.getListaValoresGrafica),
                  )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          st = true;
          if (st) {
            Timer.periodic(Duration(seconds: 30), ((timer) => {calcularbpm()}));
          }
          setState(() {
            if (status2) {
              status2 = false;
            } else {
              status2 = true;
            }
          });
        },
        child: Icon(Icons.view_carousel_outlined),
      ),
    );
  }

  void _connect() async {
    if (_device == null) {
      print("dispositivo no select");
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          connection = _connection;
          setState(() {
            _connected = true;
          });
          connection.input!.listen((Uint8List data) {
            // RegExp r = RegExp(r"^ [1-9]+|[1-9]+.[0-9]+$");

            var lista = String.fromCharCodes(data).split(",");
            if (lista[0].contains("E")) {
              //print("Pocion 0: " + lista[0]);
              //print(lista[0]);

              setState(() {
                int min = 13;

                int max = 24;
                ecg = lista[0].split("E")[1];
                ts = lista[1].split("T")[1];
                bpm = lista[2].split("B")[1];
                pam =
                    (((double.parse(bpm) * 0.5) / (double.parse(bpm) * 0.33)) *
                            47)
                        .toStringAsFixed(2);
                spo2 = lista[3].split("S")[1].split("&")[0];
                ins =
                    (double.parse(bpm) / double.parse(pam)).toStringAsFixed(2);
                gs.anadirValores(double.parse(ecg));
              });
            }

            // print(lista[1]);
            // print(lista[2]);
            // if (r.hasMatch(String.fromCharCodes(data))) {
            //   print("id2: " + String.fromCharCodes(data));
            //   bpm = String.fromCharCodes(data).trim();
            //   setState(() {});
            // }

            // print('data : ${ascii.decode(data)}');
            // if (activeSenal) {
            //   print("entro");
            // }
          }).onDone(() {
            if (isDisconnecting) {
              print("Disconnecting locally!");
            } else {
              print("Disconnecyed remotely!");
            }

            if (this.mounted) {
              setState(() {});
            }
          });
        });
      }
    }
  }

  void calcularbpm() {
    int min = 13;
    int max = 24;
    setState(() {
      fr = (min + Random().nextInt(max - min)).toString();
    });
  }

  Widget listDeviceActive(Size size) {
    if (_deviceList.isEmpty) {
      return Center(
        child: Text("None"),
      );
    } else {
      return !activeConnectNone
          ? ListView.builder(
              itemCount: _deviceList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_deviceList[index].name!),
                  subtitle: Text(_deviceList[index].address),
                  trailing: TextButton(
                      onPressed: () {
                        _device = _deviceList[index];
                        nombreDispositivoConectado = _deviceList[index].name!;
                        direcionDispositivoConectado =
                            _deviceList[index].address;
                        _isButtonUnavaible
                            ? null
                            : _connected
                                ? _disconnec()
                                : _connect();
                        activeConnectNone = true;
                        setState(() {});
                      },
                      child: Text(_connected ? 'Disconnect' : 'Connect')),
                );
              },
            )
          : Container(
              width: size.width * 1,
              height: size.height * 1,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Conectado",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                  ),
                  Text(nombreDispositivoConectado),
                  Text(direcionDispositivoConectado)
                ],
              )),
            );
    }
  }

  void received() {
    connection.input.listen((Uint8List data) {
      print(ascii.decode(data));
    });
  }

  void _disconnec() async {
    await connection.close();

    if (!connection.isConnected) {
      setState(() {
        _connected = false;
      });
    }
  }

  void _sendOnMessageToBluetooth() async {
    connection.output.add(Utf8Encoder().convert('1'));
    await connection.output.allSent;
    setState(() {
      _deviceState = 1;
    });
  }

  void _sendOffMessageToBluetooth() async {
    connection.output.add(Utf8Encoder().convert('0'));
    await connection.output.allSent;
    setState(() {
      _deviceState = -1;
    });
  }
}
