import 'package:uniordle/shared/exports/post_game_exports.dart';

class AbandonGameDialog extends StatelessWidget {
  const AbandonGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = statsManager.statsNotifier.value;
    final streak = stats.streak;
    final penalty = stats.abandonPenalty;

    final highlightStyle = context.labelMedium.copyWith(
      color: context.colorScheme.error,
    );

    return BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.gameAbandon,
            color: context.colorScheme.error,
            size: context.r(64),
          ),
          SizedBox(height: context.r(8)),
          context.autoText(
            "ABANDON GAME?",
            style: context.textTheme.displayLarge,
            textAlign: TextAlign.center,
            reduction: 8,
            maxLines: 2,
          ),
          SizedBox(height: context.r(16)),
          Text.rich(
            TextSpan(
              style: context.labelMedium,
              children: [
                const TextSpan(
                  text: "Leaving early will result in a penalty of ",
                ),
                TextSpan(text: "$penalty demerits", style: highlightStyle),
                if (streak > 0) ...[
                  const TextSpan(text: " and the loss of your "),
                  TextSpan(text: "$streak win streak", style: highlightStyle),
                ],
                const TextSpan(text: "."),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.r(32)),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  label: 'CANCEL',
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              SizedBox(width: context.r(16)),
              Expanded(
                child: PrimaryButton(
                  label: 'LEAVE',
                  color: context.colorScheme.error,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<bool> show(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierColor: Colors.transparent,
          builder: (context) => const AbandonGameDialog(),
        ) ??
        false;
  }
}
