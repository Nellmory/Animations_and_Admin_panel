import 'package:flutter/material.dart';

class SegmentedTab extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  SegmentedTab({required this.selectedIndex, required this.onTap, super.key});

  final List<String> tabs = const ["Today", "Weekly", "Overall"];
  final Color mainColor = Color(0xFF8985E9);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 40) / 3;

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            alignment: selectedIndex == 0 ? Alignment.centerLeft : selectedIndex == 1 ? Alignment.center : Alignment.centerRight,
            child: Container(
              width: width,
              height: double.infinity,
              margin: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Row(
            children: tabs.asMap().entries.map((e) {
              final idx = e.key;
              final text = e.value;
              final isSelected = selectedIndex == idx;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(idx),
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}