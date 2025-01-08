import 'package:flutter/material.dart';

class ViewButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ViewButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 32.91,
        width: 76,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.51),
          border: Border.all(
            color: const Color(0XFFE4E4E4),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15.42,
            color: Color(0XFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
