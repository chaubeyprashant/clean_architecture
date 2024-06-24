import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:calsoft/utils/app_sizes.dart';

class CPUUsageWidget extends StatelessWidget {
  final List<double> cpuUsageData;

  const CPUUsageWidget({required this.cpuUsageData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * AppSizes.chartHeightRatio,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (cpuUsageData.length - 1).toDouble(),
          minY: 0,
          maxY: 100,
          titlesData: const FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: cpuUsageData
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: AppSizes.lineChartBarWidth,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
        ),
      ),
    );
  }
}
