import 'package:flutter/material.dart';
import 'package:uniordle/uniordle/data/university_data.dart';

class CampusCard extends StatelessWidget {
  final University university;
  final VoidCallback onTap;

  static const Color matteColor = Color(0xFF1E293B);

  const CampusCard({
    super.key,
    required this.university,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onTap,
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 540,
        maxHeight: 960,
      ),
        child: Container(
          decoration: BoxDecoration(
            color: matteColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias, // keeps image inside rounded corners
          child: Column(
            children: [
              _buildImageHeader(),
              _buildCardFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageHeader() {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            university.path,
            fit: BoxFit.cover,
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    matteColor.withValues(alpha: 0.1),
                    matteColor,
                  ],
                  stops: const [0.3, 0.8, 1.0],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }

  Widget _buildCardFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            university.shortName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'NEW CODE',
                style: TextStyle(
                  color: Colors.blue.withValues(alpha: 0.8),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}