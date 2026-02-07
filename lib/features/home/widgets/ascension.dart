import 'package:uniordle/shared/exports/home_exports.dart';
import 'package:uniordle/shared/wrappers/celebration_wrapper.dart';

class Ascension extends StatelessWidget {
  const Ascension({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: statsManager.statsNotifier,
      builder: (context, stats, _) {
        final String dynamicBonus =
            "+${(stats.masteryBonusValue * 100).toInt()}%";

        return CelebrationWrapper(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon & Title
              context.autoIcon(
                AppIcons.badgeMastery,
                size: 64,
                color: context.colorScheme.secondary,
              ),
              SizedBox(height: context.r(16)),
              context.autoText("ASCENSION", style: context.headlineMedium),

              // Narrative Text
              SizedBox(height: context.r(12)),
              context.autoText(
                "You have done it, Oracle. Every major mastered, every archive opened. "
                "You have transcended the university and reached the end of the path. Well Done.",
                textAlign: TextAlign.center,
                style: context.labelMedium,
                maxLines: 4,
              ),

              // Legacy Bonus Card
              SizedBox(height: context.r(32)),
              _buildLegacyCard(context, dynamicBonus),

              // Action Button
              SizedBox(height: context.r(32)),
              PrimaryButton(
                label: 'So it is written',
                color: context.colorScheme.secondary,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLegacyCard(BuildContext context, String bonus) {
    final Color accentColor = context.colorScheme.secondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          context.autoText(
            "THE ORACLE'S LEGACY",
            style: context.labelSmall.copyWith(
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          context.autoText(
            "$bonus PERMANENT MERIT",
            style: context.headlineMedium.copyWith(
              color: accentColor,
              fontSize: 20,
            ),
            reduction: 8,
          ),
        ],
      ),
    );
  }
}
