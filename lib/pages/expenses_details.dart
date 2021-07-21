import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/rendering.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;
import 'package:expenses_app/utils/utils.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({Key key}) : super(key: key);

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  ScrollController _controller;
  String title = 'Desglose de Gastos';
  String titleExp;

  @override
  void initState() { 
    _controller = ScrollController();
    _isCollapsed;
    super.initState();
  }

  bool get _isCollapsed {
    return _controller.hasClients && _controller.offset > (90 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    final features = exProvider.features;
    List<CombinedModel> cList = [];

    expenses.forEach((x) { 
      features.forEach((y) { 
        if(x.link == y.id) {
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

    titleExp = op.getSumOfExpenses(expenses);
    var totalExp = expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);

    _controller.addListener((){
      if(_isCollapsed){
        setState(() {
          title = 'Total';
        });
      } else {
        setState(() {
          title = 'Desglose de Gastos';
        });
      }
    });

    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          _sliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              BodyDetails(cList: cList, totalExp: totalExp)
            ]
          ))
        ],
      ),
    );
  }

  _sliverAppBar(){
    return SliverAppBar(
      elevation: 8.0,
      expandedHeight: 110.0,
      floating: false,
      pinned: true,
      title: Text(title),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        title: Text('\$ $titleExp'),
        centerTitle: true,
        background: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Total'),
        ),
      )
    );
  }
}

class BodyDetails extends StatelessWidget {
  final List<CombinedModel> cList;
  final double totalExp;

  const BodyDetails({Key key, this.cList, this.totalExp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    cList.sort((a,b) => b.day.compareTo(a.day));

    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        height: size.height,
        decoration: Constants.ftBoxDecoration,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cList.length,
          itemBuilder: (_, i) {
            var item = cList[i];
            return ListTile(
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
                  Text(item.category),
                  SizedBox(width: 8.0),
                  Icon(
                    item.icon.toIcons(),
                    color: item.color.toColor(),
                    size: 18.0
                  )
                ],
              ),
              subtitle: Text(item.comment),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$ ${op.getCleanData(item.expense)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '${(100 * item.expense / totalExp).toStringAsFixed(2)}%',
                    style: TextStyle(
                      fontSize: 11.0
                    ),
                  )
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}