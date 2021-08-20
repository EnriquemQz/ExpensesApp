
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as elements;
import 'package:charts_flutter/src/text_style.dart' as styless;


class ChartLine extends StatelessWidget {
  static String pointerAmount;
  static String pointerDay;
  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final currentMonth = uiProvider.selectedMonth + 1;
    final expenses = exProvider.expenses;
    Map<int, double> mapExp;
    List<CombinedModel> cModel = [];
    List<double> perDayList;

    // example whit Map
    mapExp = expenses.fold({}, (Map<int, double> map, exp){
      if(!map.containsKey(exp.day)){
        map[exp.day] = 0.0;
      }
      map[exp.day] += exp.expense;
      return map;
    });

    mapExp.entries.forEach((e) { 
      cModel.add(CombinedModel(
        day: e.key,
        expense: e.value
      ));
    });

    cModel.add(CombinedModel(day: 0, expense: 0.0));
    cModel.sort((a,b) => a.day.compareTo(b.day));
    
    List<charts.Series<CombinedModel, num>> series = [
      charts.Series<CombinedModel, num>(
        id: 'ExpensesPerDay',
        domainFn: (v, i) => v.day,
        measureFn: (v, i) => v.expense,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.green[400]),
        data: cModel,
        // radiusPxFn: (v, i){
        //   if (v.expense == 0){
        //     return 0;
        //   }
        //   return 3;
        // },
      ),
    ];

    // example whit double list 
    var currentDay = daysInMonth(currentMonth);
    print(currentDay);

    perDayList = List.generate(currentDay + 1, (int i){
      return expenses 
        .where((e) => e.day == (i))
        .map((e) => e.expense)
        .fold(0.0, (a, b) => a +b);
    });
    print(perDayList);

    List<charts.Series<double, int>> series2 = [
      charts.Series<double, int>(
        id: 'Expenses',
        domainFn:  (v , i) => i,
        measureFn: (v , i) => v,
        seriesColor: charts.ColorUtil.fromDartColor(Colors.green[400]),
        radiusPxFn: (v, i){
          if (v == 0){
            return 0;
          }
          return 3;
        },
        data: perDayList
      )
    ];

    return Container(
      child: charts.LineChart(
        series2,
        animate: true,
        defaultRenderer: charts.LineRendererConfig(
          includePoints: true,
          includeArea: true,
          areaOpacity: 0.3
        ),
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(Colors.green[100])
            ),
            labelAnchor: charts.TickLabelAnchor.after,
            labelJustification: charts.TickLabelJustification.outside
          ),
          tickFormatterSpec: charts.BasicNumericTickFormatterSpec
          .fromNumberFormat(NumberFormat.simpleCurrency(
            decimalDigits: 0
          )),
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
            desiredTickCount: 8
          ),
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
              if(model.hasDatumSelection){
                pointerAmount = model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index)
                  .toStringAsFixed(2);
                pointerDay = model.selectedSeries[0]
                  .domainFn(model.selectedDatum[0].index)
                  .toString();
              }
            }
          )
        ],
        behaviors: [
          charts.LinePointHighlighter(
            showHorizontalFollowLine: charts
              .LinePointHighlighterFollowLineType.nearest,
            showVerticalFollowLine: charts
              .LinePointHighlighterFollowLineType.nearest,
            symbolRenderer: SymbolRender()
          ),
          charts.SelectNearest(
            eventTrigger: charts.SelectionTrigger.tapAndDrag
          )
        ],
      )
    );
  }
}


class SymbolRender extends charts.CircleSymbolRenderer {
  var textStyle = styless.TextStyle();

  @override
  void paint(
    charts.ChartCanvas canvas, 
    Rectangle<num> bounds, 
    {List<int> dashPattern, 
    charts.Color fillColor, 
    charts.FillPatternType fillPattern, 
    charts.Color strokeColor, 
    double strokeWidthPx
    }) {
    
    super.paint(
      canvas, 
      bounds,
      dashPattern : dashPattern, 
      fillColor : fillColor, 
      fillPattern : fillPattern,
      strokeColor : strokeColor, 
      strokeWidthPx : strokeWidthPx
    );

    canvas.drawRect(
      Rectangle(
        bounds.left - 25,
        bounds.top - 30,
        bounds.width + 48,
        bounds.height + 18
      ),
      fill: charts.ColorUtil.fromDartColor(Colors.grey[900]),
      stroke: charts.ColorUtil.fromDartColor(Colors.white),
      strokeWidthPx: 1,
    );
    textStyle.color = charts.MaterialPalette.white;
    textStyle.fontSize = 10;

    canvas.drawText(
      elements.TextElement(
        'Dia ${ChartLine.pointerDay} \n\$${ChartLine.pointerAmount}',
        style: textStyle
      ),
      (bounds.left - 20).round(),
      (bounds.top - 24).round()
    );
  }
}

