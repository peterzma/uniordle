import 'package:uniordle/shared/exports/stats_exports.dart';

class GuessDistributionChart extends StatefulWidget {
  final Map<int, int> distribution;

  const GuessDistributionChart({
    super.key,
    required this.distribution,
  });

  @override
  State<GuessDistributionChart> createState() => _GuessDistributionChartState();
}

class _GuessDistributionChartState extends State<GuessDistributionChart> {
  bool _shouldAnimate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _shouldAnimate = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxCount = widget.distribution.values.fold(0, (max, e) => e > max ? e : max);
    final effectiveMax = maxCount == 0 ? 1 : maxCount;

    return Column(
      children: List.generate(8, (index) {
        final guessNumber = index + 1;
        final count = widget.distribution[guessNumber] ?? 0;
        
        return DistributionBar(
          label: "$guessNumber",
          count: count,
          progress: _shouldAnimate ? (count / effectiveMax) : 0.0,
          isHighest: count > 0 && count == maxCount,
        );
      }),
    );
  }
}