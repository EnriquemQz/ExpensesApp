import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UnicornButton> childButtons = [];

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: 'Ingreso',
      labelFontSize: 16.0,
      labelColor: Colors.white,
      labelBackgroundColor: Colors.grey[850],
      currentButton: FloatingActionButton(
        heroTag: 'AddEntries',
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        mini: true,
        child: Icon(Icons.add, size: 35.0),
        onPressed: (){
        Navigator.of(context).pushNamed('add_entries');     
        },
      ),
    ));

    childButtons.add(UnicornButton(
      hasLabel: true,
      labelText: 'Gasto',
      labelFontSize: 16.0,
      labelColor: Colors.white,
      labelBackgroundColor: Colors.grey[850],
      currentButton: FloatingActionButton(
        heroTag: 'AddExpenses',
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        mini: true,
        child: Icon(Icons.remove, size: 35.0),
        onPressed: (){
          Navigator.of(context).pushNamed('add_expenses');
        },
      ),
    ));

    return UnicornDialer(
      hasBackground: true,
      childPadding: 1,
      orientation: UnicornOrientation.VERTICAL,
      parentButton: Icon(Icons.add),
      childButtons: childButtons,
    );
  }
}