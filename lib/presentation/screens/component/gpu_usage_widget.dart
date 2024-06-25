import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GPUUsageWidget extends StatelessWidget {
  final List<double> gpuUsageData;

  const GPUUsageWidget({required this.gpuUsageData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // If gpuUsageData is empty, create a flat line data
    final List<FlSpot> gpuDataSpots = gpuUsageData.isNotEmpty
        ? gpuUsageData
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value))
        .toList()
        : [const FlSpot(0, 0), const FlSpot(1, 0)]; // Flat line from (0,0) to (1,0)

    return SizedBox(
      height: screenHeight * 0.3,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: gpuUsageData.isNotEmpty ? (gpuUsageData.length - 1).toDouble() : 1,
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
              spots: gpuDataSpots,
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
