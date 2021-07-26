
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/utils.dart';

class CategoriesFlayer extends StatelessWidget {
  const CategoriesFlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final exProvider = Provider.of<ExpensesProvider>(context);
    final features = exProvider.features;
    final expenses = exProvider.expenses;

    List<CombinedModel> cList = [];
    List<CombinedModel> limitList = [];
    bool limit5 = false;

    expenses.forEach((x) { 
      features.forEach((y) { 
        if(x.link == y.id){
          var _expense = expenses.where((e) => e.link == y.id)
            .fold(0.0, (a, b) => a + b.expense);
          cList.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            // comment: x.comment,
            expense: _expense
          ));
        }
      });
    });

    var encode = cList.map((e) => jsonEncode(e)).toList();
    var unique = encode.toSet().toList();
    var result = unique.map((e) => jsonDecode(e)).toList();
    cList = result.map((e) => CombinedModel.fromJson(e)).toList();

    
    if(cList.length >= 6){
      limitList = cList.sublist(0, 5);
      limit5 = true;
    } 

    if (limitList.length == 5){
      limitList.add(
        CombinedModel(
          category: 'Otros..',
          icon: 'otros',
          color: '#20634b'
        )
      );
    }

    
    
    return Padding(
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 14.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 14.0, bottom: 8.0),
            width: size.width,
            child: Text(
              'Categorias de Gastos',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.5
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: Constants.flayer,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: (limit5) ? limitList.length : cList.length,
                        itemBuilder: (_, i){
                          var item = cList[i];
                          if(limit5 == true) {
                            item = limitList[i];
                          }
                          return ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -4.0),
                            horizontalTitleGap: -10.0,
                            leading: Icon(
                              item.icon.toIcons(),
                              color: item.color.toColor(),
                            ),
                            title: Text(
                              item.category, 
                              style: TextStyle(
                                fontSize: 14.0,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: (){
                              Navigator.pushNamed(
                                context, 'categories_details', arguments: item);
                            },
                            // trailing: Text('\$${item.expense.toString()}'),
                          );
                        }
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image(
                          image: AssetImage('assets/pie.png')
                        ),
                      )  
                    )
                  ],
                ),
                GestureDetector(
                  child: Align(
                    alignment: Alignment.centerRight,
                    widthFactor: 4.8,
                    child: Text(
                      'DETALLES',
                      style: TextStyle(
                        fontSize: 12.0,
                        letterSpacing: 1.5
                      ),
                    ),
                  )
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}