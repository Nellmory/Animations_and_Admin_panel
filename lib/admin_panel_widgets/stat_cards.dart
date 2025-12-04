import 'package:flutter/material.dart';
import 'painters.dart';

class CompactNeonCard extends StatelessWidget {
  final String title;
  final String value;
  final int percentage;
  final bool isPositive;
  final List<Color> gradientColors;

  const CompactNeonCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = percentage / 100.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        decoration: BoxDecoration(
          color: const Color(0xFF15132a),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.trending_up : Icons.trending_down,
                        color: isPositive ? Colors.greenAccent : Colors.redAccent,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "${isPositive ? '+' : ''}$percentage%",
                        style: TextStyle(
                          color: isPositive ? Colors.greenAccent : Colors.redAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: CircularProgressIndicator(
                      value: 1.0,
                      strokeWidth: 6,
                      backgroundColor: Colors.white.withOpacity(0.1),
                    ),
                  ),
                  CustomPaint(
                    size: const Size(72, 72),
                    painter: NeonCirclePainter(
                      progress: progress,
                      colors: gradientColors,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sparkline extends StatelessWidget {
  final List<double> data;
  final Color color;

  const Sparkline({super.key, required this.data, required this.color});

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: const Size(double.infinity, 60),
    painter: SparklinePainter(data, color),
  );
}