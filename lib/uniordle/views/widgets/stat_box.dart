import 'package:flutter/material.dart';

class StatBox extends StatelessWidget {
  final String title;
  final String value;

  const StatBox({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF303436),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF8E9599),
              fontSize: 16,
              fontFamily: 'dm-sans',
              fontWeight: FontWeight.w500
              ),
            ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
            value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontFamily: 'clashdisplay',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}