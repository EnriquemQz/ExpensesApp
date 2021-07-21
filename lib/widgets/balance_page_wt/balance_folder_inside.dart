import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';

import 'package:expenses_app/widgets/balance_page_wt/categories_flayer.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:provider/provider.dart';


class BalanceFolderInside extends StatelessWidget {
  const BalanceFolderInside({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    bool hasData = false;

    if(expenses.isNotEmpty){
      hasData = true;
    }

    return Container(
      decoration: Constants.fiBoxDecoration,
      child: (hasData) 
      ?ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CategoriesFlayer()
        ],
      )
      :ListView(
        padding: EdgeInsets.all(25.0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Image(
            image: AssetImage('assets/noexp.png')
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'No Tienes Movimientos en este mes',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 1.3
              ),
            )
          ),
          Container(
            // padding: EdgeInsets.all(16.0),
            child: Text(
              'Agrega pulsando el botón (+)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                letterSpacing: 1.3
              ),
            ),)
        ],
      ) 
    );
  }
}