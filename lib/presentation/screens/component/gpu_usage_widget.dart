import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GPUUsageWidget extends StatelessWidget {
  final List<double> gpuUsageData;

  const GPUUsageWidget({required this.gpuUsageData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.3,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: (gpuUsageData.length - 1).toDouble(),
          minY: 0,
          maxY: 100,
          titlesData: const FlTitlesData(
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false, interval: 20),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false, interval: 20),
            ),
            topTitles:  AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: gpuUsageData
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
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
