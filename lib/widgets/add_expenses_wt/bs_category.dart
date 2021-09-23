import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/widgets/add_expenses_wt/admin_category.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:expenses_app/models/feature_model.dart';
import 'package:expenses_app/utils/constants.dart';

import 'package:expenses_app/models/combined_model.dart';
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/utils/utils.dart';

import 'add_new_category.dart';

class BottomSheetCategory extends StatefulWidget {
  final CombinedModel cModel;
  BottomSheetCategory({Key key, this.cModel}) : super(key: key);

  @override
  _BottomSheetCategoryState createState() => _BottomSheetCategoryState();
}

class _BottomSheetCategoryState extends State<BottomSheetCategory> {
  bool hasData = false;
  final prefs = new UserPrefs();
  @override
  Widget build(BuildContext context) {
    final exProvider = Provider.of<ExpensesProvider>(context);
    final features = exProvider.features;
    Size size = MediaQuery.of(context).size;

    if(features.isEmpty){
      exProvider.callCatListJson();
      final jsonList = exProvider.cListJson;
      jsonList.forEach((e) { 
        exProvider.addNewFeature(e.category, e.color, e.icon);
      });
    }
    
    if(widget.cModel.category != 'Selecciona Categoría'){
      hasData = true;
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.category_outlined, size: 35.0),
        GestureDetector(
          onTap: () => _categorySelected(size, features ),
          child: Container(
            width: size.width / 1.5,
            decoration: BoxDecoration(
              border: (hasData)
                ? Border.all(color: widget.cModel.color.toColor())
                : Border.all(color: Colors.grey[700]),
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.cModel.category
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _categorySelected(Size size, List<FeatureModel> features){

    void _categoryName(int link, String category, String color){
      setState(() {
        widget.cModel.category = category;
        widget.cModel.color = color;
        widget.cModel.link = link;
        Navigator.pop(context);
      });
    }

    features.sort((a,b) => a.category.compareTo(b.category));

    var widgets = <Widget>[
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: features.length,
        itemBuilder: (_, i)=> ListTile(
          leading: Icon(
            features[i].icon.toIcons(),
            size: 35.0,
            color: features[i].color.toColor(),
          ),
          title: Text(features[i].category),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16.0,
          ),
          onTap: (){
            _categoryName(
              features[i].id,
              features[i].category,
              features[i].color
            );
          },
        )
      ),
      Divider(
        thickness: 2.0
      ),
      ListTile(
        leading: Icon(Icons.create_new_folder_outlined, size: 35.0),
        title: Text('Crear nueva categoría'),
        trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
        onTap: (){
          Navigator.pop(context);
          _addNewCategory();
        },
      ),
      ListTile(
        leading: Icon(Icons.edit_outlined, size: 35.0),
        title: Text('Administrar categorías'),
        trailing: Icon(Icons.arrow_forward_ios_outlined, size: 16.0),
        onTap: (){
          Navigator.pop(context);
          _adminCategory();
        },
      )
    ];

    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0)
        )
      ),
      context: context,
      builder: (context){
        return Container(
          height: size.height / 1.3,
          child: ListView(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            children: widgets,
          ),
        );
      }
    );
  }
  _addNewCategory(){
    showModalBottomSheet(
      shape: (prefs.darkMode)
        ? DarkMode.bottomSheet
        : LightMode.bottomSheet,
      context: context, 
      builder: (_) => AddNewCategory()
    );
  }

  _adminCategory(){
    showModalBottomSheet(
      shape: (prefs.darkMode)
        ? DarkMode.bottomSheet
        : LightMode.bottomSheet,
      context: context, 
      builder: (_) => AdminCategory()
    );
  }
}