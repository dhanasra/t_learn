import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t_learn/pages/quiz/model/result.dart';
import 'package:t_learn/utils/date_utils.dart';

class BarChartItem extends StatelessWidget {
  final List<Result> results;
  const BarChartItem({
    Key? key,
    required this.results
  }) : super(key: key);

  static const incorrectColor = Colors.red;
  static const correctColor = Colors.green;
  static const unattemptedColor = Colors.blueGrey;
  static const betweenSpace = 0.2;

  BarChartGroupData generateGroupData(
      int x, double pilates, double quickWorkout, double cycling) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: correctColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          color: incorrectColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace + quickWorkout + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout + betweenSpace + cycling,
          color: unattemptedColor,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff787694),
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 0:text = "JAN";
      break;
      case 1:text = "FEB";
      break;
      case 2:text = "MAR";
      break;
      case 3:text = "APR";
      break;
      case 4:text = "MAY";
      break;
      case 5:text = "JUN";
      break;
      case 6:text = "JUL";
      break;
      case 7:text = "AUG";
      break;
      case 8:text = "SEP";
      break;
      case 9:text = "OCT";
      break;
      case 10:text = "NOV";
      break;
      case 11:text = "DEC";
      break;
      default:text = "";
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(),
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta)=>SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text( DateTimeUtils.formatDate(results[value.ceil()].date ), style: const TextStyle(
                    color: Color(0xff787694),
                    fontSize: 10,
                  )),
                ),
                reservedSize: 25,
              ),
            ),
          ),
          barTouchData: BarTouchData(enabled: false),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          barGroups: List.generate(results.length, (index) => generateGroupData(
              index,
              results[index].correct.ceilToDouble(),
              results[index].incorrect.ceilToDouble(),
              results[index].unattempted.ceilToDouble()
          )).toList(),
          maxY: 20,
        ),
      ),
    );
  }
}