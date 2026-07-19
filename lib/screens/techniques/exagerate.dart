import 'package:flutter/material.dart';
import 'dart:math';

class TechniquePracticeScreen extends StatefulWidget {
  const TechniquePracticeScreen({super.key});

  @override
  State<TechniquePracticeScreen> createState() => _TechniquePracticeScreenState();
}

class _TechniquePracticeScreenState extends State<TechniquePracticeScreen> {
  final TextEditingController _inputController = TextEditingController();
  
  // Dummy data structure imitating your existing prompt mapping mechanics
  final Map<String, String> _promptsMap = {
    "It's a bit windy outside.": "Exaggerate how strong the wind feels.",
    "The line at the grocery store was long.": "Exaggerate the time spent waiting in line.",
    "My coffee is quite hot.": "Exaggerate the heat level of this coffee.",
    "The apartment room is small.": "Exaggerate how cramped the space is.",
  };

  late String _currentPhrase;
  late String _currentInstruction;
  bool _isInputEmpty = true;

  @override
  void initState() {
    super.initState();
    _loadRandomPrompt();
    _inputController.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _inputController.removeListener(_handleTextChange);
    _inputController.dispose();
    super.initState();
  }

  void _handleTextChange() {
    setState(() {
      _isInputEmpty = _inputController.text.trim().isEmpty;
    });
  }

  /// Placeholder function pulling keys randomly. 
  /// Swap out this mock logic for your real function when ready!
  void _loadRandomPrompt() {
    final random = Random();
    List<String> keys = _promptsMap.keys.toList();
    String selectedKey = keys[random.nextInt(keys.length)];
    
    setState(() {
      _currentPhrase = selectedKey;
      _currentInstruction = _promptsMap[selectedKey]!;
      _inputController.clear();
      _isInputEmpty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131F24), // Consistent dark Duolingo palette
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.white60, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const LinearProgressIndicator(
            value: 0.2, // Visual milestone placeholder 
            backgroundColor: Color(0xFF202F36),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
            minHeight: 12,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline_rounded, color: Colors.amber),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "TECHNIQUE 1: EXAGGERATION",
                      style: TextStyle(
                        color: Color(0xFF1CB0F6), // Vibrant blue label indicator
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _currentInstruction,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Modern Flashcard Display Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2E35),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFF37464F), width: 2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.format_quote_rounded, color: Colors.white38),
                              SizedBox(width: 4),
                              Text(
                                "Base Statement",
                                style: TextStyle(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "\"$_currentPhrase\"",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Text Input field styled matching Duolingo lesson tasks
                    TextField(
                      controller: _inputController,
                      maxLines: 4,
                      maxLength: 250,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: "Type your hilarious exaggeration here...",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF202F36),
                        counterStyle: const TextStyle(color: Colors.white24),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFF37464F), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Color(0xFF1CB0F6), width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Base Footer Interactive Control Panel
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: const Color(0xFF1F2E35),
                border: Border(top: BorderSide(color: Color(0xFF37464F), width: 2)),
              ),
              child: Row(
                children: [
                  // Skip / Cycle Option
                  OutlinedButton(
                    onPressed: _loadRandomPrompt,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      side: const BorderSide(color: Color(0xFF37464F), width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Icon(Icons.refresh_rounded, color: Colors.white70),
                  ),
                  const SizedBox(width: 16),
                  
                  // Primary 3D Submission Button
                  Expanded(
                    child: GestureDetector(
                      onTap: _isInputEmpty 
                          ? null 
                          : () {
                              // Skipping actual evaluation logic for now per request details
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Response logged! Moving to next prompt.')),
                              );
                              _loadRandomPrompt();
                            },
                      child: Stack(
                        children: [
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: _isInputEmpty ? const Color(0xFF37464F) : const Color(0xFF439902),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: _isInputEmpty ? const Color(0xFF4E5D67) : const Color(0xFF58CC02),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                "SUBMIT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }
}
