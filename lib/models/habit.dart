import 'package:flutter/material.dart';

class Habit {
  final String title;
  final String frequency;
  final String icon;
  final List<Color> gradient;
  List<bool> completedDays;

  Habit(this.title, this.frequency, this.icon, this.gradient, this.completedDays);
}