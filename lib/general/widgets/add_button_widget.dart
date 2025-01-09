import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';

class AddButtonWidget extends StatelessWidget {
  final String buttontext;
  final VoidCallback onTap;
  const AddButtonWidget(
      {super.key, required this.onTap, required this.buttontext});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 386,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ClrConstant.primaryColor),
        child: Center(
          child: Text(
            buttontext,
            style: const TextStyle(fontSize: 16, color: ClrConstant.blackColor),
          ),
        ),
      ),
    );
  }
}
