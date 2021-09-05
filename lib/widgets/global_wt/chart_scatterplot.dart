import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;

class ChartScatterPlot extends StatefulWidget {
  ChartScatterPlot({Key key}) : super(key: key);

  @override
  _ChartScatterPlotState createState() => _ChartScatterPlotState();
}

class _ChartScatterPlotState extends State<ChartScatterPlot> {
  String categoryName = 'Total';
  double amount = 2500;
  int day = 0;
  int touchIndex = -1;

  @override
  void initState() { 
    super.initState();
    amount = Provider.of<ExpensesProvider>(context, listen: false)
      .expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final currentMont = uiProvider.selectedMonth + 1;
    final expenses = exProvider.expenses;
    final features = exProvider.features;
    List<CombinedModel> cModel = [];

    var currentDay = daysInMonth(currentMont);

    expenses.forEach((x){
      features.forEach((y) {
        if(x.link == y.id){
          cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            expense: x.expense,
            day: x.day
          ));
        }
       });
    });

    var maxMeasure = cModel.fold(0.0, (a,b) => a < b.expense ? b.expense : a);
    print(maxMeasure);

    List<charts.Series<CombinedModel, num>> _series(int touchIndex) {
      return [
        charts.Series<CombinedModel, num>(
          id: 'ScatterPlot',
          domainFn: (v,i) => v.day,
          measureFn: (v,i) => v.expense,
          labelAccessorFn: (v,i) => v.category,

          colorFn: (v,i) {
            var onTap = i == touchIndex;
            return (onTap)
            ? charts.ColorUtil.fromDartColor(v.color.toColor()).darker
            : charts.ColorUtil.fromDartColor(v.color.toColor());
          },

          radiusPxFn: (v,i){
            final bucket = v.expense / maxMeasure;
            var onTap = i == touchIndex;

            if(bucket < 1/4){
              return (onTap) ? 5 : 4;
            } else if ( bucket < 2/4){
              return (onTap) ? 7 : 6;
            } else {
              return (onTap) ? 9 : 8;
            }
          },
          data: cModel
        )
      ];
    }
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          top: -1,
          right: 20,
          child: Text(
            '$categoryName : \$${op.getCleanData(amount)}'
          ),
        ),
        Positioned(
          top: -1,
          left: 40,
          child: Text(
            'Día : $day'
          ),
        ),
        Container(
          child: charts.ScatterPlotChart(
            _series(touchIndex),
            animate: false,
            primaryMeasureAxis: charts.NumericAxisSpec(
              tickFormatterSpec: charts.BasicNumericTickFormatterSpec
                .fromNumberFormat(NumberFormat.simpleCurrency(
                  decimalDigits: 0
                )),
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
                  desiredTickCount: 5
                )
            ),
            domainAxis: charts.NumericAxisSpec(
              tickProviderSpec: charts.StaticNumericTickProviderSpec(
                [
                  charts.TickSpec(0, label: '0'),
                  charts.TickSpec(5, label: '05'),
                  charts.TickSpec(10, label: '10'),
                  charts.TickSpec(15, label: '15'),
                  charts.TickSpec(20, label: '20'),
                  charts.TickSpec(25, label: '25'),
                  charts.TickSpec(currentDay, label: '${currentDay.toString()}'),
                ]
              )
            ),
            selectionModels: [
              charts.SelectionModelConfig(
                changedListener: (charts.SelectionModel model){
                  setState(() {
                    if(model.hasDatumSelection){
                      touchIndex = model.selectedDatum[0].index;
                      categoryName = model.selectedSeries[0]
                        .labelAccessorFn(model.selectedDatum[0].index);
                      amount = model.selectedSeries[0]
                        .measureFn(model.selectedDatum[0].index);
                      day = model.selectedSeries[0]
                        .domainFn(model.selectedDatum[0].index);
                    }
                  });
                }
              )
            ],
          ),
          
        )
      ],
    );
  }
}