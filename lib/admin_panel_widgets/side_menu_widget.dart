import 'package:flutter/material.dart';

class SideMenuWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const SideMenuWidget({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      color: const Color(0xFF15132a),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _buildMenuItem(Icons.dashboard, "Dashboard", 0),
          _buildMenuItem(Icons.calendar_today, "Calendar", 1),
          _buildMenuItem(Icons.inbox, "Inbox", 2),
          _buildMenuItem(Icons.work, "Jobs", 3, hasBadge: true, badgeCount: 11),
          _buildMenuItem(Icons.people, "Candidate", 4),
          _buildMenuItem(Icons.analytics, "Analytics", 5),
          _buildMenuItem(Icons.description, "Documents", 6),
          const Spacer(),
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFa1458e), Color(0xFF431e7e)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.rocket_launch, color: Colors.white, size: 56),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "Boost your work\nUpgrade to premium here\nUpgrade Now >",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon,
      String title,
      int index, {
        bool hasBadge = false,
        int badgeCount = 0,
      }) {
    final bool isSelected = selectedIndex == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFFa1458e) : Colors.white60,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white60,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF431e7e).withOpacity(0.3),
      onTap: () => onItemSelected(index),
      trailing: hasBadge
          ? Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFFa1458e),
          shape: BoxShape.circle,
        ),
        child: Text(
          "$badgeCount",
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      )
          : null,
    );
  }
}