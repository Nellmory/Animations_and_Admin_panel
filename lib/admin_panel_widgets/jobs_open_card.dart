import 'package:flutter/material.dart';

class JobsOpenCard extends StatelessWidget {
  const JobsOpenCard({super.key});

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
                "Jobs Open",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 220,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search here",
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 20),
                    filled: true,
                    fillColor: const Color(0xFF1c1a38),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.tune, size: 18),
                label: const Text("Filter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1c1a38),
                  foregroundColor: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white60),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2.5),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(2),
              3: FlexColumnWidth(1.8),
              4: FlexColumnWidth(1.2),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.white24)),
                ),
                children: ["Job Title", "Job Type", "Company", "Deadline", "Applicants"]
                    .map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      Text(
                        t,
                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_upward, size: 14, color: Colors.white38),
                    ],
                  ),
                ))
                    .toList(),
              ),
              ...[
                ["UI Designer", "Freelance", "Kleon Studio", "January 14, 2022", "100"],
                ["Front-End Dev.", "Fulltime", "Portu Studio", "January 14, 2022", "100"],
                ["Backend Developer", "Part-time", "Nexlify", "February 1, 2022", "87"],
              ].map(
                    (row) => TableRow(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.white10)),
                  ),
                  children: row
                      .map((cell) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      cell,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}