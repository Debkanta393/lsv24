import 'package:flutter/material.dart';
import 'package:metube/database/database.dart';
import 'package:get/get.dart';

class PlanBadgeWidget extends StatelessWidget {
  const PlanBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final badge = Database.purchasedPlanBadgeRx.value;
    if (badge.isEmpty) return const SizedBox.shrink();

    return _buildBadge(badge);
  }

  Widget _buildBadge(String badge) {
    switch (badge) {
      case 'Business':
        // ✅ Green single tick
        return const Icon(
          Icons.check_circle,
          color: Color(0xFF4CAF50), // Green
          size: 20,
        );

      case 'Influencer':
        // 🔵 Blue single tick
        return const Icon(
          Icons.check_circle,
          color: Color(0xFF1E88E5), // Blue
          size: 20,
        );

      case 'Celebrity':
        // 🔵🔵 Double blue tick
        return const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              color: Color(0xFF1E88E5), // Blue
              size: 20,
            ),
            SizedBox(width: 1),
            Icon(
              Icons.check_circle,
              color: Color(0xFF1E88E5), // Blue
              size: 20,
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
