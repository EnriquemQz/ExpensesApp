import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CircularPercent extends StatelessWidget {
  final double percent;
  final double radius;
  final double txt;
  final Color color;
  final ArcType arc;
  const CircularPercent(
    {
      Key key,
      this.percent,
      this.radius,
      this.txt,
      this.color,
      this.arc
    }
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _percent;
    double myPercent = percent;

    if(myPercent > 1.0){
      myPercent = 1.0;
    }

    _percent = myPercent * 100;

    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      arcType: arc,
      radius: radius,
      percent: myPercent,
      progressColor: color,
      lineWidth: 12.0,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${_percent.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: txt
        ),
      )
    );
  }
}

class LinearPercent extends StatelessWidget {
  final double percent;
  final double lineH;
  final Color color;

  const LinearPercent(
    {
      Key key,
      this.percent,
      this.lineH,
      this.color
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _percent;
    double myPercent = percent;

    if(myPercent > 1.0){
      myPercent = 1.0;
    }
    _percent = myPercent * 100;

    return LinearPercentIndicator(
      backgroundColor: Colors.grey[900],
      linearGradient: LinearGradient(
        colors: [
          Colors.grey[350],
          color,
          color,
        ]
      ),
      curve: Curves.easeInToLinear,
      animation: true,
      animationDuration: 1000,
      percent: myPercent,
      lineHeight: lineH,
      // progressColor: color,
      center: Text(
        '${_percent.toStringAsFixed(0)}%',
        style: TextStyle(
          fontSize: 12.0
        ),
      ),
    );
  }
}