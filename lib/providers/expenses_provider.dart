
import 'package:expenses_app/models/category_list_json.dart';
import 'package:expenses_app/models/expenses_model.dart';

import 'package:expenses_app/models/feature_model.dart';
import 'package:expenses_app/providers/category_json.dart';
import 'package:expenses_app/providers/db_expenses_provider.dart';
import 'package:expenses_app/providers/db_feature_provider.dart';
import 'package:flutter/cupertino.dart';

class ExpensesProvider extends ChangeNotifier {

  List<CategoryListJson> cListJson = [];
  List<FeatureModel> features = [];
  List<ExpensesModel> expenses = [];

  // Add expenses
  addNewFeature(String category, String color, String icon) async {
    final newFeature = new FeatureModel(
      category: category,
      color: color,
      icon: icon
    );

    final id = await DBFeatureProvider.db.newFeatures(newFeature);
    newFeature.id = id;
    this.features.add(newFeature);
    notifyListeners();
  }

  addNewExpenses(int link, int year, int month, int day, String comment, var expense) async {
    final newExpense = new ExpensesModel(
      link: link,
      year: year,
      month: month,
      day: day,
      comment: comment,
      expense: expense
    );

    final id = await DBExpensesProvider.db.addNewExpense(newExpense);
    newExpense.id = id;
    this.expenses.add(newExpense);
    notifyListeners();
    return newExpense;
  }


  // Queries

  getAllFeatures() async {
    final res = await DBFeatureProvider.db.getAllFeatures();
    this.features = [...res];
    notifyListeners();
  }

  callCatListJson() async {
    final res = await categoryJson.loadCategories();
    this.cListJson = [...res];
    notifyListeners();
  }

  getByDate(int month, int year) async {
    final res = await DBExpensesProvider.db.getByDate(month, year);
    this.expenses = [...res];
    notifyListeners();
  }

  // updates

  updateFeatures(int id, String category, String icon, String color) async {
    final updateFeatures = FeatureModel(
      id: id,
      category: category,
      icon: icon,
      color: color
    );
    await DBFeatureProvider.db.updateFeatures(updateFeatures);
  }
}