import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/widgets/global_wt/percent_indicator.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;

class MovementsFlayer extends StatelessWidget {
  const MovementsFlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    double _percent;
    double _totalExpenses;
    double _totalEntries = 9500;

    _totalExpenses = expenses.map((e) => e.expense).fold(0.0,(a,b) => a + b);
    _percent = _totalExpenses / _totalEntries;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Expanded(
          flex: 1,
          child: CircularPercent(
            // arc: ArcType.FULL,
            percent: _percent,
            radius: 120,
            txt: 20.0,
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 170.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Gastos Realizados',
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 1.5
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '\$ ${op.getSumOfExpenses(expenses)}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Absorbe un ${(_percent * 100).toStringAsFixed(2)}% de tus ingresos.',
                    style: TextStyle(
                      fontSize: 14.0
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ]
    );
  }
}