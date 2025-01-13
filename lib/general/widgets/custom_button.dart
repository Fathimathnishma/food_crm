import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onTap;
  const CustomButton(
      {super.key, required this.onTap, required this.buttontext});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.primaryColor),
        child: Center(
          child: Text(
            buttontext,
            style: const TextStyle(fontSize: 16, color: AppColors.blackColor),
          ),
        ),
      ),
    );
  }
}
