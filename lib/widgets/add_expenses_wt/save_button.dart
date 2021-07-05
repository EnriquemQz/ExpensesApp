import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButton({Key key, @required this.cModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);

    return GestureDetector(
      onTap: (){
        if(cModel.expense != 0.00 && cModel.link != null ){

          if(cModel.comment == '') return cModel.comment = 'Sin comentarios 🙄';

          exProvider.addNewExpenses(
            cModel.link, 
            cModel.year, 
            cModel.month, 
            cModel.day, 
            cModel.comment, 
            cModel.expense
          );

          Fluttertoast.showToast(
            msg: 'Gasto Agregado',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.green,
            textColor: Colors.white
          );
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
          backgroundColor: Colors.grey[900],
          radius: 34.0,
          child: Icon(
            Icons.done_outline,
            size: 45.0,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}