import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/math_operations.dart' as op;
import 'package:expenses_app/utils/utils.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({Key key}) : super(key: key);

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  ScrollController _controller;
  String title = 'Desglose de Gastos';
  double titleExp;

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
    int dataDay = ModalRoute.of(context).settings.arguments;
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses;
    final features = exProvider.features;
    List<CombinedModel> cList = [];
    bool hasDay = false;

    if(dataDay != null){
      hasDay = true;
    } else {
      hasDay = false;
    }

    expenses.forEach((x) { 
      features.forEach((y) { 
        if((hasDay)? x.link == y.id && x.day == dataDay : x.link == y.id) {
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

    titleExp = cList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
    // var totalExp = expenses.map((e) => e.expense).fold(0.0, (a, b) => a + b);

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
              BodyExpensesDetails(cList: cList, totalExp: titleExp)
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
        title: Text('\$ ${op.getCleanData(titleExp)}'),
        centerTitle: true,
        background: Align(
          alignment: Alignment.bottomCenter,
          child: Text('Total'),
        ),
      )
    );
  }
}

class BodyExpensesDetails extends StatefulWidget {
  final List<CombinedModel> cList;
  final double totalExp;

  const BodyExpensesDetails({Key key, this.cList, this.totalExp}) : super(key: key);

  @override
  State<BodyExpensesDetails> createState() => _BodyExpensesDetailsState();
}

class _BodyExpensesDetailsState extends State<BodyExpensesDetails> {
  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    // Size size = MediaQuery.of(context).size;
    widget.cList.sort((a,b) => b.day.compareTo(a.day));
    
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Container(
        // height: size.height,
        decoration: Constants.ftBoxDecoration,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: widget.cList.length,
          itemBuilder: (_, i) {
            var item = widget.cList[i];

            if(item.comment == ''){
              item.comment = 'Sin Comentarios';
            }

            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.18,
              child: ListTile(
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
                      '${(100 * item.expense / widget.totalExp).toStringAsFixed(2)}%',
                      style: TextStyle(
                        fontSize: 11.0
                      ),
                    )
                  ],
                ),
              ),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Editar',
                  foregroundColor: Colors.blue,
                  color: Colors.transparent,
                  iconWidget: Icon(Icons.edit, color: Colors.green),
                  onTap: (){
                    Navigator.pushNamed(context, 'add_expenses', arguments: item);
                  },
                ),
                IconSlideAction(
                  caption: 'Eliminar',
                  foregroundColor: Colors.red,
                  color: Colors.transparent,
                  iconWidget: Icon(Icons.delete_forever_outlined, color: Colors.red),
                  onTap: (){
                    setState(() {
                      widget.cList.removeAt(i);
                    });
                    Fluttertoast.showToast(
                      msg: 'Gasto Eliminado',
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.red,
                      textColor: Colors.white
                    );
                    exProvider.deleteExpense(item.id);
                    uiProvider.selectedMenu = 0;
                  },
                ),
              ]
            );
          }
        ),
      ),
    );
  }
}