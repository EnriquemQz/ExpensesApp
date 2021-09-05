import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:expenses_app/utils/math_operations.dart'as op;
import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/utils.dart';

class PerCategoryList extends StatelessWidget {
  const PerCategoryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    final features = exProvider.features;
    List<CombinedModel> perCategoryList = [];

    expenses.forEach((x){
      features.forEach((y) { 
        if(x.link == y.id){
          var _expense = expenses.where((e) => e.link == y.id)
            .fold(0.0, (a, b) => a+ b.expense);

          perCategoryList.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            expense: _expense
          ));
        }
      });
    });

    var enconde = perCategoryList.map((e) => jsonEncode(e)).toList();
    var unique = enconde.toSet().toList();
    var result = unique.map((e) => jsonDecode(e)).toList();

    perCategoryList = result.map((e) => CombinedModel.fromJson(e)).toList();
    
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: perCategoryList.length,
      itemBuilder: (_,i){
        var item = perCategoryList[i];
        return ListTile(
          leading: Icon(
            item.icon.toIcons(),
            color: item.color.toColor(),
            size: 35.0,
          ),
          title: Text(item.category),
          trailing: Text(
            '\$ ${op.getCleanData(item.expense)}'
          ),
        );
      },
    );
  }
}