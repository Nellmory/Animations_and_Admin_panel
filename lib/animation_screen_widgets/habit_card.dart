import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final int appearanceDelay;
  final bool shouldAnimate;

  const HabitCard({
    required this.habit,
    this.appearanceDelay = 0,
    this.shouldAnimate = true,
    super.key,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    if (widget.shouldAnimate) {
      Future.delayed(Duration(milliseconds: widget.appearanceDelay), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDay(int index) {
    setState(() {
      widget.habit.completedDays[index] = !widget.habit.completedDays[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday - 1;
    final days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Row(
                  children: [
                    Text(
                      widget.habit.icon,
                      style: const TextStyle(fontSize: 28),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.habit.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Text(
                      widget.habit.frequency,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 0.5,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (i) {
                    final bool done = widget.habit.completedDays[i];
                    final bool isToday = i == todayIndex;

                    return GestureDetector(
                      onTap: () => _toggleDay(i),
                      child: Column(
                        children: [
                          Text(
                            days[i],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                              color: isToday ? const Color(0xFF8985E9) : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 10),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutBack,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: done
                                  ? widget.habit.gradient[0].withOpacity(0.15)
                                  : Colors.transparent,
                              border: Border.all(
                                color: done
                                    ? widget.habit.gradient[0]
                                    : Colors.grey[300]!,
                                width: done ? 2.5 : 1.8,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: done
                                ? Center(
                              child: AnimatedScale(
                                scale: done ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.elasticOut,
                                child: Icon(
                                  Icons.check,
                                  size: 22,
                                  color: widget.habit.gradient[0],
                                ),
                              ),
                            )
                                : null,
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}