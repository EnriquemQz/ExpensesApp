
import 'package:expenses_app/providers/expenses_provider.dart';
import 'package:expenses_app/providers/shared_preferences.dart';
import 'package:expenses_app/providers/ui_provider.dart';
import 'package:expenses_app/utils/constants.dart';
import 'package:expenses_app/widgets/charts_page_wt/chart_selector.dart';
import 'package:expenses_app/widgets/charts_page_wt/per_category_list.dart';
import 'package:expenses_app/widgets/charts_page_wt/per_day_list.dart';
import 'package:expenses_app/widgets/charts_page_wt/switch_charts.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ChartsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentChart = uiProvider.selectedChart;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentChart),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          _sliverAppBarWithChart(),
          SliverList(delegate: SliverChildListDelegate(
            [
              ChartsBody(currentChart: currentChart)
            ]
          ))
        ],
      ),
    );
  }
  _sliverAppBarWithChart(){
    return SliverAppBar(
      expandedHeight: 350.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChartSelector(),
              SizedBox(height: 20),
              Expanded(child: SwitchCharts()),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartsBody extends StatelessWidget {
  final String currentChart;
  const ChartsBody({this.currentChart});

  @override
  Widget build(BuildContext context) {
    final prefs = new UserPrefs();
    final size = MediaQuery.of(context).size;
    final exProvider = Provider.of<ExpensesProvider>(context);
    final expenses = exProvider.expenses.length;
    bool _height = false;
    bool _isPerDay = false;

    if(currentChart == 'Gráfico Lineal' 
      || currentChart == 'Gráfico de dispersión'){
        _isPerDay = true;
      }

    if(expenses > 6){
      _height = true;
    }

    return Container(
      height: (_height) ? null : size.height / 2,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: (prefs.darkMode)
        ? DarkMode.ftBoxDecoration
        : LightMode.ftBoxDecoration,
      child: (_isPerDay) ? PerDayList() : PerCategoryList()
    );
  }
}