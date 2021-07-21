
import 'dart:convert';

FeatureModel featureModelFromJson(String str) => FeatureModel.fromJson(json.decode(str));

String featureModelToJson(FeatureModel data) => json.encode(data.toJson());

class FeatureModel {
    FeatureModel({
        this.id,
        this.category = '',
        this.icon = 'local_gas_station_outlined',
        this.color = '#4287f5',
    });

    int id;
    String category;
    String icon;
    String color;

    factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
        id: json["id"],
        category: json["category"],
        icon: json["icon"],
        color: json["color"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "icon": icon,
        "color": color,
    };
}
