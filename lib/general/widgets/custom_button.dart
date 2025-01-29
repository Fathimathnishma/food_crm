import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttontext;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  const CustomButton(
      {super.key, required this.onTap, required this.buttontext, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color),
        child: Center(
          child: Text(
            buttontext,
            style:  TextStyle(fontSize: 16, color: textColor),
          ),
        ),
      ),
    );
  }
}
