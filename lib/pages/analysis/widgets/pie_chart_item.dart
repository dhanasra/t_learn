import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';


class PieChartItem extends StatefulWidget {
  final String correct;
  final String wrong;
  final String unAttempted;

  const PieChartItem({
    Key? key,
    required this.correct,
    required this.wrong,
    required this.unAttempted
  }) : super(key: key);

  @override
  PieChartItemState createState() => PieChartItemState();
}

class PieChartItemState extends State<PieChartItem> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
            pieTouchData: PieTouchData(touchCallback:
                (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse
                    .touchedSection!.touchedSectionIndex;
              });
            }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 50,
            sections: showingSections()),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {

    final total = double.parse(widget.wrong)+double.parse(widget.correct)+double.parse(widget.unAttempted);
    final wrongPercent = (double.parse(widget.wrong)/total)*100;
    final correctPercent = (double.parse(widget.correct)/total)*100;
    final unAttemptedPercent = (double.parse(widget.unAttempted)/total)*100;

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 55.0 : 45.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: wrongPercent.ceilToDouble(),
            title: '${wrongPercent.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: correctPercent.ceilToDouble(),
            title: '${correctPercent.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blueGrey,
            value: unAttemptedPercent.ceilToDouble(),
            title: '${unAttemptedPercent.toStringAsFixed(1)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        default:
          return PieChartSectionData(value: 0, title: '');
      }
    });
  }
}