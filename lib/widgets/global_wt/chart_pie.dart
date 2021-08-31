import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;

class ChartPie extends StatefulWidget {
  ChartPie({Key key}) : super(key: key);

  @override
  _ChartPieState createState() => _ChartPieState();
}

class _ChartPieState extends State<ChartPie> {
  String categoryName = 'TOTAL';
  String categoryColor = '#388e3c';
  String _icon = '';
  double _amount = 2500; 
  double _total;
  int touchIndex = -1;
  bool animated;

  @override
  void initState() {
    super.initState();
    _amount = Provider.of<ExpensesProvider>(context, listen: false)
      .expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);
    _total = Provider.of<ExpensesProvider>(context, listen: false)
      .expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);
    animated = true;
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    final features = exProvider.features;
    List<CombinedModel> cList = [];

    expenses.forEach((x){
      features.forEach((y) { 
        if(x.link == y.id){
          var _expenses = expenses
            .where((e) => e.link == y.id)
            .map((e) => e.expense)
            .fold(0.0, (a, b) => a + b);
          cList.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            expense: _expenses
          ));
        }
      });
    });

    var encode = cList.map((e) => jsonEncode(e)).toList();
    var unique = encode.toSet().toList();
    var result = unique.map((e) => jsonDecode(e)).toList();
    cList = result.map((e) => CombinedModel.fromJson(e)).toList();

    List<charts.Series<CombinedModel, String>> _seriesPie(int touchIndex){
      return [
        charts.Series<CombinedModel, String>(
          id: 'PieChart',
          domainFn: (v, i) => v.category,
          measureFn: (v, i) => v.expense,
          keyFn: (v, i) => v.icon,
          labelAccessorFn: (v, i) => 
            '${(v.expense * 100 / _total).toStringAsFixed(2)}%',
          colorFn: (v, i) {
           var onTap = i == touchIndex; 
  
           if(onTap == false){
             return charts.ColorUtil.fromDartColor(v.color.toColor());
           } else {
             return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
           }
          },
          outsideLabelStyleAccessorFn: (v,i){
            var onTap = i == touchIndex;

            if(onTap == false){
              return charts.TextStyleSpec(
                fontSize: 8,
                color: charts.MaterialPalette.white
              );
            } else {
              return charts.TextStyleSpec(
                fontSize: 14,
                color: charts.MaterialPalette.white,
              );
            }
          },
          data: cList
        )
      ];
    }

    print(categoryColor);
    print(touchIndex);

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        charts.PieChart(
          _seriesPie(touchIndex),
          animate: animated,
          animationDuration: Duration(milliseconds: 800),
          defaultInteractions: true,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 30,
            strokeWidthPx: 0.0,
            arcRendererDecorators: [
              charts.ArcLabelDecorator(
                labelPosition: charts.ArcLabelPosition.outside,
                showLeaderLines: true,
                labelPadding: 2,
                leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                  length: 12,
                  color: charts.MaterialPalette.white,
                  thickness: 1
                ),
                // outsideLabelStyleSpec: charts.TextStyleSpec(
                //   color: charts.MaterialPalette.white,
                //   fontSize: 10
                // ),
                insideLabelStyleSpec: charts.TextStyleSpec(
                  color: charts.MaterialPalette.white,
                  fontSize: 10
                )
              )
            ]
            // arcRatio: 0.2
          ),
          selectionModels: [
            charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model){
                if(model.hasDatumSelection){
                  setState(() {
                    animated = false;
                    touchIndex = model.selectedDatum[0].index;
                    categoryName = model.selectedSeries[0]
                      .domainFn(model.selectedDatum[0].index)
                      .toString();
                    _amount = model.selectedSeries[0]
                      .measureFn(model.selectedDatum[0].index);
                    _icon = model.selectedSeries[0]
                      .keyFn(model.selectedDatum[0].index);
                    categoryColor = model.selectedSeries[0]
                      .colorFn(model.selectedDatum[0].index)
                      .toString().replaceFirst(RegExp(r'ff'), '', categoryColor.length);
                  });
                }
              },
            )
          ],
          // behaviors: [
          //   charts.DomainHighlighter()
          // ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _icon.toIcons(),
              color: categoryColor.toColor(),
              size: 28.0,
            ),
            Text(
              categoryName
            ),
            Text(
              '\$${op.getCleanData(_amount)}'
            )
          ],
        )
      ],
    );
  }
}