
import 'package:expenses_app/widgets/global_wt/chart_scatterplot.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app/widgets/global_wt/chart_pie.dart';

import 'package:expenses_app/utils/constants.dart';

class ChartsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfico Lineal'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: CustomScrollView(
        slivers: [
          _sliverAppBarWithChart(),
          SliverList(delegate: SliverChildListDelegate(
            [
              // ChartsBody()
            ]
          ))
        ],
      ),
    );
  }
  _sliverAppBarWithChart(){
    return SliverAppBar(
      expandedHeight: 300.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: ChartScatterPlot()),
              // Container(child: Text('Hola Charts'))
            ],
          ),
        ),
      ),
    );
  }
}

class ChartsBody extends StatelessWidget {
  const ChartsBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Constants.ftBoxDecoration,
      child: Text('Body'),
    );
  }
}