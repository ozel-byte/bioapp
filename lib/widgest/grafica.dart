import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series<LinearSales, double>> seriesList;
  final bool animate;

  SimpleLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData(valores) {
    return new SimpleLineChart(
      _createSampleData(valores),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList, animate: animate);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, double>> _createSampleData(
      List<LinearSales> valores) {
    final List<LinearSales> data = valores;
    if (valores.length == 50) {
      valores.clear();
    }
    //data.add();
    //valores.map((e) => data.add(new LinearSales(e, valores.length * 1.0)));
    return [
      new charts.Series<LinearSales, double>(
        id: 'developers',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.time,
        measureFn: (LinearSales sales, _) => sales.ecg,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final double ecg;
  final double time;

  LinearSales(this.ecg, this.time);
}
