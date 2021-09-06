import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart'as op;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerDayList extends StatelessWidget {
  const PerDayList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    List<CombinedModel> _perDayList = [];
    Map<dynamic, dynamic> _perDayMap;

    _perDayMap = expenses.fold({}, (Map<dynamic, dynamic> map, element){
      if(!map.containsKey(element.day)){
        map[element.day] = 0;
      }
      map[element.day] += element.expense;
      return map;
    });

    _perDayMap.entries.forEach((e) => _perDayList
      .add(CombinedModel(
        day: e.key,
        expense: e.value
      )) 
    );

    _perDayList.sort((a,b) => b.day.compareTo(a.day));

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        childAspectRatio: 1.0
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      itemCount: _perDayList.length,
      itemBuilder: (_, i){
        var item = _perDayList[i];
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'expenses_details', arguments: item.day);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  child: Text(
                    'Día',
                    style: TextStyle(
                      letterSpacing: 1.5
                    ),
                  ),
                ),

                Divider(color: Colors.white),

                Container(
                  child: Text(
                    item.day.toString(),
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  )
                ),

                Divider(color: Colors.white),

                Container(
                  child: Text(
                    '\$ ${op.getCleanData(item.expense)}',
                    style: TextStyle(
                      letterSpacing: 1.5
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}