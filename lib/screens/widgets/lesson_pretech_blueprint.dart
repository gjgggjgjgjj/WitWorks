import 'package:flutter/material.dart';
import 'package:i_funny_flutterapp/screens/techniques/technique_vars.dart';

class TechniqueOverviewScreen extends StatelessWidget {
  final Map keymap;
  final String techniqueTitle;
  final String instruction;
  final String description;
  final List<String> keyTakeaways;
  final List<String> samplePhrases;

  const TechniqueOverviewScreen({
    required this.keymap,
    this.techniqueTitle = "TECHNIQUE 1: EXAGGERATION",
    this.instruction = "Take a simple statement and blow it completely out of proportion.",
    this.description =
        "Exaggeration takes a everyday situation and stretches the truth until it becomes absurd and funny.",
    this.keyTakeaways = const [
      "Multiply numbers by 1,000",
      "Treat mild inconveniences like apocalyptic disasters",
      "Keep a serious face while saying something impossible",
    ],
    this.samplePhrases = const [
      "\"I've been waiting for 5 minutes\" ➔ \"I've aged three generations in this line.\"",
      "\"It's a bit cold outside\" ➔ \"My ancestors are shivering in my bones.\"",
    ],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131F24), // Consistent Duolingo dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white60, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1CB0F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF1CB0F6), width: 1.5),
                      ),
                      child: Text(
                        techniqueTitle,
                        style: const TextStyle(
                          color: Color(0xFF1CB0F6),
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Main Lesson Headline
                    Text(
                      instruction,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Description Concept
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Card 1: How it Works (Key Rules)
                    _buildSectionCard(
                      title: "HOW IT WORKS",
                      icon: Icons.lightbulb_rounded,
                      iconColor: Colors.amber,
                      child: Column(
                        children: keyTakeaways
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("• ", style: TextStyle(color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: Text(
                                        item,
                                        style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Card 2: Sample Breakdown / Examples
                    _buildSectionCard(
                      title: "BEFORE & AFTER",
                      icon: Icons.auto_awesome_rounded,
                      iconColor: const Color(0xFFCE82FF),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: samplePhrases
                            .map(
                              (sample) => Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF131F24),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  sample,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    height: 1.4,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CTA Footer with 3D Button
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF1F2E35),
                border: Border(top: BorderSide(color: Color(0xFF37464F), width: 2)),
              ),
              child: GestureDetector(
                onTap: () {
                  // Replaces current overview screen with practice mode, or pushes it
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  metaphorUseScreen,
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF439902),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0xFF58CC02),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          "START PRACTICE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Helper for Duolingo-styled Card Containers
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2E35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF37464F), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
