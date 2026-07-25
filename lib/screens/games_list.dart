import 'package:flutter/material.dart';
import 'package:i_funny_flutterapp/screens/techniques/technique_vars.dart';
import 'package:i_funny_flutterapp/screens/widgets/lesson_pretech_blueprint.dart';
import 'techniques/exagerate.dart';
import '../db/game_list_map.dart';

class HumorTechniquesScreen extends StatelessWidget {
  const HumorTechniquesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Generates a list of 35 items following your temporary naming convention
    final List<String> techniques = List.generate(
      35,
      (index) => "Technique ${index + 1}",
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HUMOR TECHNIQUES',
          style: TextStyle(
            fontWeight: FontWeight.w700, //was FontWeight.black before
            letterSpacing: 1.5,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1F2E35),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
        itemCount: techniques.length,
        itemBuilder: (context, index) {
          // Math to calculate zigzag alignment: Left -> Center -> Right -> Center -> Repeat
          double alignmentX = 0.0; 
          int positionInCycle = index % 4;
          
          if (positionInCycle == 0) {
            alignmentX = -0.6; // Left
          } else if (positionInCycle == 1 || positionInCycle == 3) {
            alignmentX = 0.0;  // Center
          } else if (positionInCycle == 2) {
            alignmentX = 0.6;  // Right
          }

          return AlignmentContainer(
            alignmentX: alignmentX,
            child: TechniqueNode(
              title: techniques[index],
              index: index,
              // PLACEHOLDER: Swap your image paths/network links here easily later
              imagePath: null, 
              onTap: () {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => exagerateGameScreen,
                    ),
                  );
                }
                else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => metaphorUseScreen,
                    ),
                  );
                }

                else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TechniqueOverviewScreen(keymap: metaphorMap),
                    ),
                  );
                }

                /*
                else if (index == 3) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => foo,
                    ),
                  );
                }
                else if (index == 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => foo,
                    ),
                );

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected ${techniques[index]}')),
                  );
                }
                */
              },
            ),
          );
        },
      ),
    );
  }
}

/// Helper wrapper widget to alignment items neatly along the dynamic X axis
class AlignmentContainer extends StatelessWidget {
  final double alignmentX;
  final Widget child;

  const AlignmentContainer({
    super.key,
    required this.alignmentX,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      alignment: Alignment(alignmentX, 0),
      child: child,
    );
  }
}

/// The actual interactive visual Duolingo button/node
class TechniqueNode extends StatelessWidget {
  final String title;
  final int index;
  final String? imagePath; // Set up for quick asset/network image drops
  final VoidCallback onTap;

  const TechniqueNode({
    super.key,
    required this.title,
    required this.index,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Alternating vibrant colors for standard Duolingo styling
    final List<Color> nodeColors = [
      const Color(0xFF58CC02), // Green
      const Color(0xFF1CB0F6), // Blue
      const Color(0xFFFF9600), // Orange
      const Color(0xFFCE82FF), // Purple
    ];
    
    Color mainColor = nodeColors[index % nodeColors.length];
    // Slightly darker shade for the 3D button depth effect underneath
    Color shadowColor = mainColor.withAlpha(180); 

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              // 3D bottom shadow effect container
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: shadowColor,
                  shape: BoxShape.circle,
                ),
              ),
              // Front top container
              Container(
                width: 84,
                height: 80,
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: mainColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: imagePath == null
                      ? const Icon(
                          Icons.star, // Default placeholder star icon
                          color: Colors.white,
                          size: 36,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            imagePath!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Clean minimal text tag underneath the button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF202F36),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}