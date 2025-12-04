import 'package:flutter/material.dart';
import 'admin_panel_widgets/app_bar_widget.dart';
import 'admin_panel_widgets/applicants_chart.dart';
import 'admin_panel_widgets/jobs_open_card.dart';
import 'admin_panel_widgets/right_panel_widget.dart';
import 'admin_panel_widgets/side_menu_widget.dart';
import 'admin_panel_widgets/stat_cards.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0c0b20),
      ),
      home: const AdminScreen(),
    );
  }
}

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;
  String _selectedPeriod = 'Weekly';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0c0b20),
      appBar: const AdminAppBar(),
      body: Row(
        children: [
          SideMenuWidget(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) => setState(() => _selectedIndex = index),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CompactNeonCard(
                        title: "Total Applicants",
                        value: "12,234",
                        percentage: 53,
                        isPositive: true,
                        gradientColors: [Color(0xFF9d4edd), Color(0xFFe06c9f)],
                      ),
                      SizedBox(width: 20),
                      CompactNeonCard(
                        title: "Hired Candidates",
                        value: "2,048",
                        percentage: 75,
                        isPositive: true,
                        gradientColors: [Color(0xFF32c5ff), Color(0xFF06d6a0)],
                      ),
                      SizedBox(width: 20),
                      CompactNeonCard(
                        title: "Rejected Candidates",
                        value: "3,845",
                        percentage: 45,
                        isPositive: false,
                        gradientColors: [Color(0xFFe06c9f), Color(0xFFff6b6b)],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  ApplicantsChart(
                    selectedPeriod: _selectedPeriod,
                    onPeriodChanged: (period) =>
                        setState(() => _selectedPeriod = period),
                  ),
                  const SizedBox(height: 32),

                  const JobsOpenCard(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          const RightPanelWidget(),
        ],
      ),
    );
  }
}