

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/utils/constants.dart';
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
  bool hasData = false;

  @override
  Widget build(BuildContext context) {

    final CombinedModel modelData = ModalRoute.of(context).settings.arguments;

    if(modelData != null){
      _cModel = modelData;
      hasData = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: (hasData)? Text('Editar Gasto') : Text('Agregar Gastos'),
        centerTitle : false,
      ),
      body: FormOfExpenses(cModel: _cModel, hasData: hasData),
    );
  }
}

class FormOfExpenses extends StatefulWidget {
  final CombinedModel cModel;
  final bool hasData;
  FormOfExpenses({this.cModel, this.hasData});

  @override
  _FormOfExpensesState createState() => _FormOfExpensesState();
}

class _FormOfExpensesState extends State<FormOfExpenses> {
  
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPrefs();
    CombinedModel _cModel = widget.cModel;
    Size size = MediaQuery.of(context).size;

    if(_cModel.comment == 'Sin Comentarios'){
      _cModel.comment = '';
    }

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
          decoration: (prefs.darkMode)
            ? DarkMode.ftBoxDecoration
            : LightMode.ftBoxDecoration,
          child: Column(
            children: [
              DateSelector(cModel: _cModel),
              BottomSheetCategory(cModel: _cModel),
              SizedBox(height: 16.0),
              CommentBox(cModel: _cModel),
              Expanded(
                flex: 3, 
                child: 
                SaveButton(cModel: _cModel, hasData: widget.hasData)
              ),
              
            ],
          ),
        )
      ]);
  }
}

