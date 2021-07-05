import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

import 'package:expenses_app/models/feature_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/utils/utils.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNewCategory extends StatefulWidget {
  final FeatureModel fModelEdit;

  AddNewCategory({Key key, this.fModelEdit}) : super(key: key);

  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {

  FeatureModel fModel = new FeatureModel();

  bool fModelHasData = false;
  String catName;
  String iconName;
  String colorName;

  @override
  void initState() { 
    if(widget.fModelEdit != null){
      fModel = widget.fModelEdit;
      catName = widget.fModelEdit.category;
      iconName = widget.fModelEdit.icon;
      fModelHasData = true;
    }
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);
    final features = exProvider.features;

    Iterable<FeatureModel> contain;

    if(fModelHasData == true){
      contain = features.where((e) => 
        e.category.toLowerCase() == catName.toLowerCase());
    } else {
      contain = features.where((e) => 
        e.category.toLowerCase() == fModel.category.toLowerCase());
    }

    _addNewCategory(){
      if(contain.isNotEmpty){
        Fluttertoast.showToast(
          msg: 'Ya existe esta categoría',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white
        );
      } else if (fModel.category.isNotEmpty){
        exProvider.addNewFeature(
          fModel.category, 
          fModel.color, 
          fModel.icon
        );
        Fluttertoast.showToast(
          msg: 'Categoría Creada',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white
        );
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: 'Nombra una categoría',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white
        );
      }
    }

    _editCategory(){
      if(fModel.category.toLowerCase() == catName.toLowerCase()){
        exProvider.updateFeatures(
          fModel.id, 
          fModel.category, 
          fModel.icon, 
          fModel.color
        );
        Fluttertoast.showToast(
          msg: 'Se editó Correctamente',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white
        );
        uiProvider.selectedMenu = 0;
        Navigator.pop(context);
      } else if(contain.isNotEmpty){
        Fluttertoast.showToast(
          msg: 'Ya existe esta categoría',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white
        );
      } else if(catName.isNotEmpty){
        exProvider.updateFeatures(
          fModel.id, 
          catName, 
          fModel.icon, 
          fModel.color
        );
        Fluttertoast.showToast(
          msg: 'Se editó Correctamente',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.green,
          textColor: Colors.white
        );
        uiProvider.selectedMenu = 0;
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: 'Nombra una categoría',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white
        );
      }
    }

    return SingleChildScrollView(
      child: Container(
        height: size.height / 2.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTile(
              trailing: Icon(Icons.text_fields, size: 35.0),
              title: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: fModel.category,
                  decoration: InputDecoration(
                    hintText: 'Nombre categoría',
                    border: InputBorder.none
                  ),
                  onChanged: (txt){
                    (fModelHasData) ? catName = txt : fModel.category = txt;
                  },
                ),
              ),
            ),
            ListTile(
              trailing: CircleAvatar(
                backgroundColor: fModel.color.toColor(),
                radius: 16.0,
              ),
              title: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: Center(child: Text('Color')) ,
              ),
              onTap: (){
                _selectColor(context);
              },
            ),
            ListTile(
              trailing: Icon(fModel.icon.toIcon(), size:35.0),
              title: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black
                  ),
                  borderRadius: BorderRadius.circular(25.0)
                ),
                child: Center(child: Text('Icono')) ,
              ),
              onTap: (){
                _selectIcon(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: Constants.btnCancel,
                        child: Center(child: Text('CANCELAR')),
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: Constants.btnOk,
                        child: Center(child: Text('LISTO')),
                      ),
                      onTap: (){
                        (fModelHasData) ? _editCategory() : _addNewCategory();
                      },
                    ),
                  )
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
  _selectColor(context){

    void _changeColor(String color){
      setState(() {
        fModel.color = color;
      });
    }

    showModalBottomSheet(
      shape: Constants.bottomSheet,
      context: context, 
      builder: (_){
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialColorPicker(
                selectedColor: fModel.color.toColor(),
                shrinkWrap: true,
                circleSize: 55.0,
                onColorChange: (Color color){
                  var hexColor = '#${color.value.toRadixString(16).substring(2,8)}';
                  _changeColor(hexColor);
                },
              ),
              GestureDetector(
                child: Container(
                  width: 150.0,
                  padding: EdgeInsets.all(12.0),
                  decoration: Constants.btnOk,
                  child: Center(
                    child: Text('LISTO')
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ],
          )
        );
      }
    );
  }

  _selectIcon(context){
    final iconList = IconPicker().colorSelect;

    void _changedIcon(String icon){
      setState(() {
        fModel.icon = icon;
      });
    }

    showModalBottomSheet(
      shape: Constants.bottomSheet,
      context: context, 
      builder: (_){
        return Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5
            ),
            itemCount: iconList.length,
            itemBuilder: (_,i){
              return GestureDetector(
                child: Icon(
                  iconList[i].toIcon(),
                  size: 30.0,
                  color: Colors.white,
                ),
                onTap: (){
                  _changedIcon(iconList[i]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      }
    );
  }
}