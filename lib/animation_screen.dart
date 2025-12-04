import 'package:animation_and_admin/animation_screen_widgets/segmented_tab.dart';
import 'package:flutter/material.dart';
import 'models/habit.dart';
import 'animation_screen_widgets/habit_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HabitsScreen(),
    );
  }
}

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});
  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  int selectedTab = 1;
  int selectedNavIndex = 0;
  final Color mainColor = Color(0xFF8985E9);

  final List<Habit> habits = [
    Habit("Set Small Goals", "Everyday", "🎯",
        [const Color(0xFFFB8B9B), const Color(0xFFFBA8B4)], [true, true, false, true, true, true, false]),
    Habit("Meditation", "5 days per week", "😇",
        [const Color(0xFF6EE2B5), const Color(0xFF8BE6C1)], [true, true, true, false, true, false, false]),
    Habit("Work", "Everyday", "🏆",
        [const Color(0xFFFFD28B), const Color(0xFFFFE4B0)], [true, true, true, true, true, true, true]),
    Habit("Sleep Over 8h", "Everyday", "😴",
        [const Color(0xFF9B8BFB), const Color(0xFFB8A8FB)], [false, true, true, true, true, false, true]),
    Habit("Basketball", "5 days per week", "🏀",
        [const Color(0xFFFF9B8B), const Color(0xFFFFB8A8)], [true, false, true, false, true, false, false]),
    Habit("Exercise Workout", "Everyday", "🥊",
        [const Color(0xFF8BDBFB), const Color(0xFFA8E1FB)], [true, true, false, true, true, true, false]),
    Habit("Playing Games", "4 days per week", "🕹",
        [const Color(0xFFFF8BEB), const Color(0xFFFFA8F0)], [false, true, false, true, false, true, true]),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF8F9FA),
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.auto_awesome, color: mainColor),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Home", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87)),
            ],
          ),
          actions: [IconButton(icon: const Icon(Icons.more_vert, color: Colors.black54), onPressed: () {})],
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SegmentedTab(selectedIndex: selectedTab, onTap: (i) => setState(() => selectedTab = i)),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 20),
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final isLast = index == habits.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(bottom: isLast ? 80 : 4),
                    child: HabitCard(
                      key: ValueKey(habits[index].title),
                      habit: habits[index],
                      appearanceDelay: index * 90,
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        floatingActionButton: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9B8BFB), Color(0xFF7B6EFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8985E9).withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 32),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -4)),
            ],
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                    color: mainColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  );
                }
                return TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                );
              }),
            ),
            child: NavigationBar(
              height: 76,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedIndex: selectedNavIndex,
              indicatorColor: Colors.transparent,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              onDestinationSelected: (index) => setState(() => selectedNavIndex = index),
              destinations: [
                NavigationDestination(
                  icon: const Icon(Icons.home_outlined, size: 26, color: Colors.grey),
                  selectedIcon: Icon(Icons.home, size: 30, color: mainColor),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.sentiment_satisfied_outlined, size: 26, color: Colors.grey),
                  selectedIcon: Icon(Icons.sentiment_satisfied, size: 30, color: mainColor),
                  label: 'Mood Stat',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.bar_chart_outlined, size: 26, color: Colors.grey),
                  selectedIcon: Icon(Icons.bar_chart, size: 30, color: mainColor),
                  label: 'Report',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.list_alt_outlined, size: 26, color: Colors.grey),
                  selectedIcon: Icon(Icons.list_alt, size: 30, color: mainColor),
                  label: 'My Habits',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.person_outline, size: 26, color: Colors.grey),
                  selectedIcon: Icon(Icons.person, size: 30, color: mainColor),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}