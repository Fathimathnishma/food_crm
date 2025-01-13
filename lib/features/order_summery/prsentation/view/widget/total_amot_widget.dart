import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/app_colors.dart';

class TotalAmountContainer extends StatelessWidget {
  final String title;
  final String amount;
  final String buttonText;
  final VoidCallback onTap;

  const TotalAmountContainer({
    super.key,
    required this.title,
    required this.amount,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.greyColor,
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.greyColor,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                height: 44,
                width: 99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
