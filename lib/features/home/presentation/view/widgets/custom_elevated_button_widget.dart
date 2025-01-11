import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 38.0,
    this.width = 112.0,
    required this.backgroundColor,
    this.textColor = Colors.black,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ClrConstant.primaryColor),
        child: SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
