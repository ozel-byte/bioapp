import 'dart:async';

import 'package:bioapp/src/widgest/grafica.dart';

class GraficaStream {
  List<LinearSales> listaGrafica = [];

  StreamController<List<LinearSales>> _streamController =
      new StreamController.broadcast();

  Stream<List<LinearSales>> get getGraficaStream => _streamController.stream;
  get getListaValoresGrafica => listaGrafica;

  void anadirValores(double num) {
    listaGrafica.add(LinearSales(num, listaGrafica.length * 1.0));
    if (listaGrafica.length == 180.0) {
      listaGrafica.clear();
    }
    _streamController.sink.add(listaGrafica);
  }
}
