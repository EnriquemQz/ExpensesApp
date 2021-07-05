
import 'dart:convert';

CategoryListJson defaultCategoryFromJson(String str) => CategoryListJson.fromJson(json.decode(str));

String defaultCategoryToJson(CategoryListJson data) => json.encode(data.toJson());

class CategoryListJson {
    CategoryListJson({
        this.category,
        this.icon,
        this.color,
    });

    String category;
    String icon;
    String color;

    factory CategoryListJson.fromJson(Map<String, dynamic> json) => CategoryListJson(
        category: json["category"],
        icon: json["icon"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "icon": icon,
        "color": color,
    };
}
