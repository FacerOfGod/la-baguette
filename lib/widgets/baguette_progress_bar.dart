import 'package:flutter/material.dart';
import 'package:baguette/core/theme.dart';

class BaguetteProgressBar extends StatelessWidget {
  final double pourPercent;
  final double contrePercent;
  final double abstentionPercent;

  const BaguetteProgressBar({
    super.key,
    required this.pourPercent,
    required this.contrePercent,
    required this.abstentionPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: AppTheme.beige,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.brown.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Row(
          children: [
            if (pourPercent > 0)
              Expanded(
                flex: pourPercent.round(),
                child: Container(
                  color: Colors.green.shade400,
                  child: const Center(
                    child: Icon(Icons.check, size: 16, color: Colors.white),
                  ),
                ),
              ),
            if (contrePercent > 0)
              Expanded(
                flex: contrePercent.round(),
                child: Container(
                  color: AppTheme.red,
                  child: const Center(
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
            if (abstentionPercent > 0)
              Expanded(
                flex: abstentionPercent.round(),
                child: Container(
                  color: Colors.grey.shade400,
                  child: const Center(
                    child: Icon(Icons.remove, size: 16, color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
