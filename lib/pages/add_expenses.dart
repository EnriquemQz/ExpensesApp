

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_category.dart';
import 'package:expenses_app/widgets/add_expenses_wt/date_selector.dart';
import 'package:expenses_app/widgets/add_expenses_wt/save_button.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/widgets/add_expenses_wt/bs_number.dart';
import 'package:expenses_app/widgets/add_expenses_wt/comment_box.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key key}) : super(key: key);

  @override
  _AddExpensesState createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  CombinedModel _cModel = new CombinedModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Gastos'),
        centerTitle : false,
      ),
      body: FormOfExpenses(cModel: _cModel),
    );
  }
}

class FormOfExpenses extends StatefulWidget {
  final CombinedModel cModel;
  FormOfExpenses({this.cModel});

  @override
  _FormOfExpensesState createState() => _FormOfExpensesState();
}

class _FormOfExpensesState extends State<FormOfExpenses> {
  
  @override
  Widget build(BuildContext context) {
    CombinedModel _cModel = widget.cModel;

    Size size = MediaQuery.of(context).size;
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: BottomSheetNumber(cModel: _cModel),
        ),
        Container(
          padding: EdgeInsets.all(18.0),
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            )
          ),
          child: Column(
            children: [
              DateSelector(cModel: _cModel),
              BottomSheetCategory(cModel: _cModel),
              SizedBox(height: 16.0),
              CommentBox(cModel: _cModel),
              Expanded(
                flex: 3, 
                child: 
                SaveButton(cModel: _cModel)
              ),
              
            ],
          ),
        )
      ]);
  }
}

