import 'package:flutter/material.dart';

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final bool hasBorder;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    required this.color,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded( 
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: hasBorder
              ? const BorderSide(color: Color(0xFF303436), width: 1)
              : BorderSide.none,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontFamily: 'clashdisplay',
            fontWeight: FontWeight.w400,
          ),
        )
      ),
    );  
  }
}