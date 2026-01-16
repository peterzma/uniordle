import 'package:flutter/material.dart';

class WordLengthSelector extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  static const _activeColor = Color(0xFF38BDF8);
  static const _inactiveBg = Color(0x0DFFFFFF);
  static const _inactiveBorder = Color(0x1AFFFFFF);

  const WordLengthSelector({
    super.key, 
    required this.value, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'WORD LENGTH',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [5, 6, 7].map((len) {
            final active = value == len;
            return GestureDetector(
              onTap: () => onChanged(len),
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: active ? Colors.blue : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: active ? Colors.blue : Colors.white10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$len',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'LETTERS',
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}