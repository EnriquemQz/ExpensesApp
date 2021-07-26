import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:expenses_app/utils/utils.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;
import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/widgets/global_wt/percent_indicator.dart';



class CategoriesDetails extends StatefulWidget {
  const CategoriesDetails({Key key}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  CombinedModel cModel;
  double totalCList;
  double totalExpenses;
  double expensesPercent;
  double entriesPercent;

  @override
  Widget build(BuildContext context) {
   cModel = ModalRoute.of(context).settings.arguments;

   final exProvider = Provider.of<ExpensesProvider>(context);
   final expenses = exProvider.expenses;
   final features = exProvider.features;
   List<CombinedModel> cList = [];

   expenses.forEach((x) { 
      features.forEach((y) { 
        if(x.link == y.id && y.category == cModel.category) {
          cList.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            id: x.id,
            link: x.link,
            year: x.year,
            month: x.month,
            day: x.day,
            comment: x.comment,
            expense: x.expense
          ));
        }
      });
    });

    totalCList = cList.map((e) => e.expense).fold(0.0,(a,b) => a + b);
    totalExpenses = expenses.map((e) => e.expense).fold(0.0, (a,b) => a + b);
    expensesPercent = totalCList / totalExpenses;
    entriesPercent = totalCList / 3500.00;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              BodyCategoriesDetails(cList: cList)
            ]
          ))
        ],
      )
    );
  }

  _sliverAppBar(){
    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      title: Row(
        children:[
          Expanded(
            child: Text(
              cModel.category,
              style: TextStyle(
                color: cModel.color.toColor()
              ),
            ),
          ),
          Expanded(
            child: Text(
              '\$ ${op.getCleanData(totalCList)}'
            ),
          )
        ]
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter / 2,
                children: [
                  Text(
                    '/Ingresos \$3,500.00',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[400]
                    ),
                  ),
                  CircularPercent(
                    percent: entriesPercent,
                    radius: 120.0,
                    color: Colors.green,
                    arc: ArcType.HALF,
                    txt: 25.0,
                  )
                ],
              ),
              Stack(
                alignment: AlignmentDirectional.bottomCenter / 2,
                children: [
                  Text(
                    '/gastos \$ ${op.getCleanData(totalExpenses)}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[400]
                    ),
                  ),
                  CircularPercent(
                    percent: expensesPercent,
                    radius: 120.0,
                    color: Colors.red,
                    arc: ArcType.HALF,
                    txt: 25.0,
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}

class BodyCategoriesDetails extends StatelessWidget {
  final List<CombinedModel> cList;
  const BodyCategoriesDetails({Key key, this.cList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var totalCList = cList.map((e) => e.expense).fold(0.0,(a,b) => a + b);

    return Container(
      height: size.height,
      decoration: Constants.ftBoxDecoration,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cList.length,
        itemBuilder: (_ , i){
         var item = cList[i];
         if(item.comment == ''){
           item.comment = 'Sin Comentarios';
         }
          return ListTile(
            dense: true,
            leading: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Icon(Icons.calendar_today, size: 40.0),
                Positioned(
                  top: 16.0,
                  child: Text(item.day.toString()),
                )
              ],
            ),
            title: Row(
              children: [
                Expanded(
                  child: LinearPercent(
                    percent: item.expense / totalCList,
                    lineH: 14.0,
                    color: item.color.toColor()
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                item.comment
              ),
            ),
            trailing: Text(
              '\$ ${op.getCleanData(item.expense)}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            ),
          );
        },
      ),
    );
  }
}