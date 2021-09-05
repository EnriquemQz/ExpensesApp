import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/widgets/global_wt/chart_line.dart';
import 'package:expenses_app/widgets/global_wt/chart_pie.dart';
import 'package:expenses_app/widgets/global_wt/chart_scatterplot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchCharts extends StatelessWidget {
  const SwitchCharts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentChart = uiProvider.selectedChart;

    switch(currentChart){
      case 'Gráfico Lineal' :
        return ChartLine();
      case 'Gráfico Circular' :
        return ChartPie();
      case 'Gráfico de dispersión' :
        return ChartScatterPlot();
      default : 
        return ChartLine();
    }
  }
}