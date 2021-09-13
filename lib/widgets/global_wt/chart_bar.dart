import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import 'package:expenses_app/providers/expenses_provider.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    double _expenses;
    double _entries = 3500;

    _expenses = expenses.map((e) => e.expense).fold(0.0,(a,b) => a + b);

    final data = [
      OrdinalSales('Ingresos', _entries, Colors.green),
      OrdinalSales('Gastos', _expenses, Colors.red)
    ];

    List<charts.Series<OrdinalSales, String>> seriesList = [
      charts.Series<OrdinalSales, String>(
        id: 'Balance',
        domainFn: (v, i) => v.name,
        measureFn: (v, i) => v.money,
        colorFn: (v , i) => charts.ColorUtil.fromDartColor(v.color),
        data: data
      )
    ];

    return Container(
      child: charts.BarChart(
        seriesList,
        animate: false,
        defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: charts.ConstCornerStrategy(50)
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 0
          )
        ),
      ),
    );
  }
}

class OrdinalSales {
  String name;
  double money;
  Color color;

  OrdinalSales(this.name, this.money, this.color);

}