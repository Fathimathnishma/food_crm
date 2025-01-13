import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/app_colors.dart'; // Ensure this import is in place

class TotalCardWidget extends StatelessWidget {
  final String subtitle;

  const TotalCardWidget({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 340,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.whiteColor,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Total",
              style: TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "₹$subtitle",
              style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
