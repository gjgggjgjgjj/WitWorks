import 'package:flutter/material.dart';
import '../../models/game_spitter.dart';

class TechniquePracticeScreen extends StatefulWidget {
  final Map keymap;
  final String instruction;

  const TechniquePracticeScreen({
    required this.keymap,
    required this.instruction,
    super.key,
  });

  @override
  State<TechniquePracticeScreen> createState() => _TechniquePracticeScreenState();
}

class _TechniquePracticeScreenState extends State<TechniquePracticeScreen> {
  final TextEditingController _inputController = TextEditingController();

  late String _currentPhrase;
  late List<String> _currentExamples;
  int _currentExampleIndex = 0; // Tracks which example is currently visible
  bool _isInputEmpty = true;
  bool _showExamples = false;

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
    super.dispose();
  }

  void _handleTextChange() {
    setState(() {
      _isInputEmpty = _inputController.text.trim().isEmpty;
    });
  }

  void _loadRandomPrompt() {
    final selectedKey = randomKeySpitter(widget.keymap);

    setState(() {
      _currentPhrase = selectedKey;
      _currentExamples = getexamples(widget.keymap, selectedKey)
          .map((example) => example.toString())
          .toList();
      _currentExampleIndex = 0; // Reset index to the first example
      _inputController.clear();
      _isInputEmpty = true;
      _showExamples = false;
    });
  }

  void _toggleExamples() {
    setState(() {
      _showExamples = !_showExamples;
    });
  }

  void _nextExample() {
    if (_currentExamples.isEmpty) return;
    setState(() {
      _currentExampleIndex = (_currentExampleIndex + 1) % _currentExamples.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF131F24),
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
            value: 0.2,
            backgroundColor: Color(0xFF202F36),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
            minHeight: 12,
          ),
        ),
        actions: [
          // Lightbulb button in top AppBar
          IconButton(
            tooltip: "Need Help",
            icon: Icon(
              Icons.lightbulb_outline_rounded,
              color: _showExamples ? Colors.amber : Colors.white38,
            ),
            onPressed: _toggleExamples,
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
                        color: Color(0xFF1CB0F6),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.instruction,
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
                                style: TextStyle(
                                  color: Colors.white38,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '"$_currentPhrase"',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                              height: 1.4,
                            ),
                          ),

                          // Single Active Example View with Navigation Controls
                          if (_showExamples && _currentExamples.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Example ${_currentExampleIndex + 1} of ${_currentExamples.length}',
                                  style: const TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                if (_currentExamples.length > 1)
                                  InkWell(
                                    onTap: _nextExample,
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Next Example',
                                            style: TextStyle(
                                              color: Color(0xFF1CB0F6),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            color: Color(0xFF1CB0F6),
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '• ${_currentExamples[_currentExampleIndex]}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),
                          ],

                          // Helpful prompt line if user hasn't tapped help yet
                          if (!_showExamples) ...[
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: _toggleExamples,
                              child: const Row(
                                children: [
                                  Icon(Icons.help_outline_rounded, color: Colors.amber, size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    "Need help? Tap for examples",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Text Input Field
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
                color: Color(0xFF1F2E35),
                border: Border(top: BorderSide(color: Color(0xFF37464F), width: 2)),
              ),
              child: Row(
                children: [
                  // Refresh Button
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
