import 'package:expenses_app/providers/ui_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSelector extends StatefulWidget {
  ChartSelector({Key key}) : super(key: key);

  @override
  _ChartSelectorState createState() => _ChartSelectorState();
}

class BubbleTab extends StatelessWidget {
  final IconData icon;
  final bool selected;
  const BubbleTab(
    {
      Key key, this.icon, this.selected
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(25.0)
      ),
      child: Icon(icon),
    );
  }
}

class _ChartSelectorState extends State<ChartSelector> {
  // String currentChart = 'Gráfico Lineal';
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentChart = uiProvider.selectedChart;

    var _widgets = <Widget>[];

    Map<String, IconData> typeChart = {
      'Gráfico Lineal' : Icons.show_chart,
      'Gráfico Circular' : CupertinoIcons.chart_pie,
      'Gráfico de dispersión' : Icons.bubble_chart
    };

    typeChart.forEach((name, icon){
      _widgets.add(
        GestureDetector(
          onTap: (){
            setState(() {
              uiProvider.selectedChart = name;
            });
          },
          child: BubbleTab(
            icon: icon,
            selected: currentChart == name,
          ),
        )
      );
    });

    return Container(
      height: 40.0,
       child: Center(
         child: ListView(
           physics: NeverScrollableScrollPhysics(),
           shrinkWrap: true,
           itemExtent: 80.0,
           scrollDirection: Axis.horizontal,
           children: _widgets,
         ),
       ),
    );
  }
}