

import 'dart:convert';

import 'package:expenses_app/models/category_list_json.dart';
import 'package:flutter/services.dart' show rootBundle;


class CategoryJson{

  List<CategoryListJson> catList;

  Future<List<CategoryListJson>> loadCategories() async {

    final res = await rootBundle.loadString('data/category_opts.json');
    Map _decode = json.decode(res);
    List<dynamic> _list = _decode['results'];

    catList = _list.map((e) => CategoryListJson.fromJson(e)).toList();
    return catList;
  }
}

final categoryJson = new CategoryJson();