import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomSheetNumber extends StatefulWidget {
  final CombinedModel cModel;
  BottomSheetNumber({Key key, this.cModel}) : super(key: key);

  @override
  _BottomSheetNumberState createState() => _BottomSheetNumberState();
}

class _BottomSheetNumberState extends State<BottomSheetNumber> {
  final prefs = new UserPrefs();
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function mathFunc = (Match match) => '${match[1]},';

  String import = '0.00';
  
  @override
  void initState() {
    import = widget.cModel.expense.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => _numPad(size),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Cantindad Ingresada'),
          SizedBox(height: 10.0),
          Text(
            '\$${import.replaceAllMapped(reg, mathFunc)}',
            style: TextStyle(
              fontSize: 30.0,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
  
  _numPad(Size size){

    if(import == "0.00"){
      import = '';
    }

    _expenseChange(String expense){
      if(expense == ''){
        expense = '0.00';
        widget.cModel.expense = double.parse(expense);
      } else {
       widget.cModel.expense = double.parse(expense);
      }
      
    }

    _num(String text, double height){
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          setState(() {
            import += text;
            _expenseChange(import);
          });
        },
        child: Container(
          height: height,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 35.0,
                // color: Colors.white
              ),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
      backgroundColor: (prefs.darkMode)
       ? DarkMode.bsNumberColor
       : LightMode.bsNumberColor,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0)
        )
      ),
      context: context, 
      builder: (context){
        return Container(
          height: size.height / 2.5,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints){
              var height = constraints.biggest.height / 5.0;
              return Column(
                children: [
                  Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(
                        color: Colors.grey,
                        width: 0.1
                      )
                    ),
                    children: [
                      TableRow(children: [
                        _num('1', height),
                        _num('2', height),
                        _num('3', height),
                      ]),
                      TableRow(children: [
                        _num('4', height),
                        _num('5', height),
                        _num('6', height),
                      ]),
                      TableRow(children: [
                        _num('7', height),
                        _num('8', height),
                        _num('9', height),
                      ]),
                      TableRow(children: [
                        _num('.', height),
                        _num('0', height),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            setState(() {
                              if ( import != null && import.length > 0.0) {
                                import = import.substring(0, import.length - 1);
                                _expenseChange(import);
                              }
                            });
                          },
                          child: Container(
                            height: height,
                            child: Center(
                              child: Icon(
                                Icons.backspace,
                                // color: Colors.white,
                                size: 35.0,
                              )
                            ),
                          )
                        )
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: (prefs.darkMode)
                              ? DarkMode.btnCancel
                              : LightMode.btnCancel,
                            height: height / 1.8,
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){
                                setState(() {
                                  import = '0.00';
                                  _expenseChange(import);
                                  Navigator.pop(context);
                                });
                              },
                              child: Center(
                                child: Text(
                                  'CANCELAR',
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          flex: 1,
                          child: Container(
                           decoration: (prefs.darkMode)
                            ? DarkMode.btnOk
                            : LightMode.btnOk,
                           height: height / 1.8,
                           child: GestureDetector(
                             behavior: HitTestBehavior.opaque,
                             onTap: (){
                               setState(() {
                                 if(import == ''){
                                   import = '0.00';
                                 }
                                   Navigator.pop(context);
                               });
                             },
                             child: Center(
                               child: Text('ACEPTAR'),
                             )
                           ),
                        ),
                         )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        );
      }
    );
  }
}