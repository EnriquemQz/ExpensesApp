import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;
  const SaveButton({Key key, @required this.cModel, this.hasData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = UserPrefs();
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    return GestureDetector(
      onTap: (){
        if(cModel.expense != 0.00 && cModel.link != null ){
          (hasData)
          ? exProvider.updateExpenses(
            cModel.id, 
            cModel.link, 
            cModel.year,
            cModel.month, 
            cModel.day, 
            cModel.comment, 
            cModel.expense
          )
          : exProvider.addNewExpenses(
            cModel.link, 
            cModel.year, 
            cModel.month, 
            cModel.day, 
            cModel.comment, 
            cModel.expense
          );

          if(hasData == true){
            Fluttertoast.showToast(
              msg: 'Tu Gasto se editó correctamete',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green,
              textColor: Colors.white
            );
            uiProvider.selectedMenu = 0;
          } else{
            Fluttertoast.showToast(
              msg: 'Gasto Agregado',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green,
              textColor: Colors.white
            );
          }
          Navigator.pop(context);
        } else if(cModel.expense == 0.0){
          Fluttertoast.showToast(
            msg: 'Necesitas agregar un gasto',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white
          );
        } else {
          Fluttertoast.showToast(
            msg: 'Selecciona una categoría',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.red,
            textColor: Colors.white
          );
        }
        
      },
      child: CircleAvatar(
        backgroundColor: Colors.green,
        radius: 35.0,
        child: CircleAvatar(
          backgroundColor: (prefs.darkMode)
           ? Colors.grey[850]
           : Colors.grey[200],
          radius: 34.0,
          child: Icon(
            Icons.done,
            size: 45.0,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}