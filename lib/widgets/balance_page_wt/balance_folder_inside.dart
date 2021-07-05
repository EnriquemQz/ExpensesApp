import 'dart:convert';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';

import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:provider/provider.dart';


class BalanceFolderInside extends StatelessWidget {
  const BalanceFolderInside({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final features = exProvider.features;
    final expenses = exProvider.expenses;

    List<CombinedModel> cList = [];

    expenses.forEach((x) { 
      features.forEach((y) { 
        if(x.link == y.id){
          var _expense = expenses.where((e) => e.link == y.id)
            .fold(0.0, (a, b) => a + b.expense);
          cList.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            comment: x.comment,
            expense: _expense
          ));
        }
      });
    });

    var encode = cList.map((e) => jsonEncode(e)).toList();
    var unique = encode.toSet().toList();
    var result = unique.map((e) => jsonDecode(e)).toList();
    cList = result.map((e) => CombinedModel.fromJson(e)).toList();

    return Container(
      decoration: Constants.fiBoxDecoration,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: cList.length,
            itemBuilder: (_, i){
              var item = cList[i];
              return ListTile(
                leading: Icon(item.icon.toIcon(), color: item.color.toColor()),
                title: Text(item.category),
                trailing: Text(item.expense.toStringAsFixed(2)),
              );
            },
          )
        ],
      ),
    );
  }
}