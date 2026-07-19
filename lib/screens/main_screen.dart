import 'package:flutter/material.dart';
import 'games_list.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // App Branding / Header Section
              const Text(
                "Welcome Back,",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white60,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Wit Works",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),

              // Highlighted/Featured Card: Humor Techniques
              MenuModuleCard(
                title: "Humor Techniques",
                subtitle: "Master the 35 core comedic formulas step-by-step.",
                icon: Icons.psychology_rounded,
                gradientColors: const [Color(0xFF6366F1), Color(0xFF4F46E5)], // Modern Indigo
                isFeatured: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HumorTechniquesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Subheading for secondary options
              const Text(
                "Practice & Tools",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white38,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),

              // Grid for other placeholder features
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  MenuModuleCard(
                    title: "Daily Exercises",
                    subtitle: "Quick daily writing prompts",
                    icon: Icons.create_rounded,
                    gradientColors: const [Color(0xFF10B981), Color(0xFF059669)], // Emerald
                    onTap: () {},
                  ),
                  MenuModuleCard(
                    title: "My Notebook",
                    subtitle: "Saved drafts & bits",
                    icon: Icons.book_rounded,
                    gradientColors: const [Color(0xFFF59E0B), Color(0xFFD97706)], // Amber
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A modern, reusable card module with subtle gradients and drop shadows
class MenuModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final VoidCallback onTap;
  final bool isFeatured;

  const MenuModuleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.onTap,
    this.isFeatured = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: EdgeInsets.all(isFeatured ? 24.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(icon, color: Colors.white, size: isFeatured ? 40 : 28),
                    if (isFeatured)
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 18),
                  ],
                ),
                SizedBox(height: isFeatured ? 32 : 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isFeatured ? 22 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: isFeatured ? 14 : 12,
                        color: Colors.white.withValues(alpha: 0.87)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

