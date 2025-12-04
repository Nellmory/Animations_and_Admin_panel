import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ApplicantsChart extends StatefulWidget {
  final String selectedPeriod;
  final ValueChanged<String> onPeriodChanged;

  const ApplicantsChart({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  State<ApplicantsChart> createState() => _ApplicantsChartState();
}

class _ApplicantsChartState extends State<ApplicantsChart> {
  final Set<String> _activeLegends = {'Front-End Developer', 'UI Designer'};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF15132a),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Applicants",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              _buildSegmentedButton(),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 280,
            child: LineChart(
              _neonChartData(),
              duration: const Duration(milliseconds: 300),
            ),
          ),
          const SizedBox(height: 24),
          _buildLegend(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildSegmentedButton() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1c1a38),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _segmentItem("Daily", widget.selectedPeriod == 'Daily'),
          _segmentItem("Weekly", widget.selectedPeriod == 'Weekly'),
        ],
      ),
    );
  }

  Widget _segmentItem(String text, bool active) {
    return GestureDetector(
      onTap: () => widget.onPeriodChanged(text),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFa1458e) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.white60,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 16,
      runSpacing: 10,
      children: [
        _buildClickableLegendItem("Front-End Developer", const Color(0xFF9d4edd)),
        _buildClickableLegendItem("UI Designer", const Color(0xFFe06c9f)),
        _buildClickableLegendItem("UX Researcher", const Color(0xFF32c5ff)),
        _buildClickableLegendItem("Product Manager", const Color(0xFF06d6a0)),
      ],
    );
  }

  Widget _buildClickableLegendItem(String label, Color color) {
    final bool active = _activeLegends.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (active) {
            _activeLegends.remove(label);
          } else {
            _activeLegends.add(label);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: active ? color.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? color : Colors.white24,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: active ? color : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color, width: 2),
                boxShadow: active
                    ? [BoxShadow(color: color.withOpacity(0.8), blurRadius: 12, spreadRadius: 2)]
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : Colors.white60,
                fontSize: 13,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _neonChartData() {
    final bool isWeekly = widget.selectedPeriod == 'Weekly';

    final List<FlSpot> dailyApproved = const [
      FlSpot(0, 65), FlSpot(1, 72), FlSpot(2, 68), FlSpot(3, 55),
      FlSpot(4, 48), FlSpot(5, 60), FlSpot(6, 45),
    ];
    final List<FlSpot> dailyPending = const [
      FlSpot(0, 52), FlSpot(1, 58), FlSpot(2, 62), FlSpot(3, 48),
      FlSpot(4, 42), FlSpot(5, 52), FlSpot(6, 38),
    ];
    final List<FlSpot> weeklyApproved = const [
      FlSpot(0, 420), FlSpot(1, 480), FlSpot(2, 460), FlSpot(3, 510),
      FlSpot(4, 490), FlSpot(5, 550), FlSpot(6, 520),
    ];
    final List<FlSpot> weeklyPending = const [
      FlSpot(0, 380), FlSpot(1, 420), FlSpot(2, 440), FlSpot(3, 400),
      FlSpot(4, 390), FlSpot(5, 430), FlSpot(6, 410),
    ];

    final bool showApproved = _activeLegends.contains("Front-End Developer");
    final bool showPending = _activeLegends.contains("UI Designer");

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: isWeekly ? 100 : 20,
        getDrawingHorizontalLine: (_) => FlLine(
          color: Colors.white.withOpacity(0.08),
          strokeWidth: 1,
        ),
      ),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            getTitlesWidget: (value, _) {
              const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(days[value.toInt()], style: const TextStyle(color: Colors.white38, fontSize: 12)),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: isWeekly ? 100 : 20,
            getTitlesWidget: (value, meta) {
              final int val = value.toInt();
              if (isWeekly) {
                if (val == 0 || (val % 100 == 0 && val <= 600)) {
                  return Text('$val', style: const TextStyle(color: Colors.white38, fontSize: 11));
                }
              } else {
                if (val == 0 || (val % 20 == 0 && val <= 100)) {
                  return Text('$val', style: const TextStyle(color: Colors.white38, fontSize: 11));
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: isWeekly ? 600 : 110,
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => const Color(0xFF1e1b3a).withOpacity(0.95),
          tooltipRoundedRadius: 12,
          tooltipPadding: const EdgeInsets.all(12),
          getTooltipItems: (touchedSpots) {
            const dates = ['Jan 24', 'Jan 25', 'Jan 26', 'Jan 27', 'Jan 28', 'Jan 29', 'Jan 30'];
            return touchedSpots.map((spot) {
              final label = spot.barIndex == 0 ? 'Approved' : 'Pending';
              return LineTooltipItem(
                '${dates[spot.x.toInt()]}\n${spot.y.toInt()} Applications\n$label',
                TextStyle(
                  color: spot.barIndex == 0 ? const Color(0xFF9d4edd) : const Color(0xFFe06c9f),
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        if (showApproved)
          LineChartBarData(
            spots: isWeekly ? weeklyApproved : dailyApproved,
            isCurved: true,
            barWidth: 4,
            color: const Color(0xFF9d4edd),
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFF9d4edd).withOpacity(0.4), Colors.transparent],
                stops: const [0.0, 0.8],
              ),
            ),
            shadow: Shadow(color: const Color(0xFF9d4edd).withOpacity(0.6), blurRadius: 16),
          ),
        if (showPending)
          LineChartBarData(
            spots: isWeekly ? weeklyPending : dailyPending,
            isCurved: true,
            barWidth: 4,
            color: const Color(0xFFe06c9f),
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xFFe06c9f).withOpacity(0.4), Colors.transparent],
                stops: const [0.0, 0.8],
              ),
            ),
            shadow: Shadow(color: const Color(0xFFe06c9f).withOpacity(0.6), blurRadius: 16),
          ),
      ],
    );
  }
}