
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;
import 'package:flutter/material.dart';
import 'package:expenses_app/widgets/global_wt/chart_bar.dart';
import 'package:provider/provider.dart';

class BalanceFlayer extends StatelessWidget {
  const BalanceFlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    double _expenses;
    double _entries = 3500;
    double _total;

    _expenses = expenses.map((e) => e.expense).fold(0.0,(a,b) => a + b);
    _total = _entries - _expenses;

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                title: Text('Ingresos'),
                trailing: Text(
                  '\$${op.getCleanData(_entries)}',
                  style: TextStyle(
                    color: Colors.green
                  )
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                title: Text('Gastos'),
                trailing: Text(
                  '\$${op.getCleanData(_expenses)}',
                  style: TextStyle(
                    color: Colors.red
                  )
                ),
              ),
              Divider(
                indent: 15.0,
                endIndent: 15.0,
                thickness: 2.0,
                // color: Colors.white,
              ),
              ListTile(
                dense: true,
                visualDensity: VisualDensity(vertical: -4),
                title: Text('Balance'),
                trailing: Text(
                  '\$${op.getCleanData(_total)}',
                  style: TextStyle(
                    color: (_total < 0)
                      ? Colors.red
                      : Colors.green
                  )
                ),
              ),

            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(height: 180.0, child: ChartBar())
        )
      ],
    );
  }
}