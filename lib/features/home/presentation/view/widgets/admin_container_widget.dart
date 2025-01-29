import 'package:flutter/material.dart';

class AdminContainerWidget extends StatefulWidget {
  const AdminContainerWidget({super.key});

  @override
  State<AdminContainerWidget> createState() => _AdminContainerWidgetState();
}

class _AdminContainerWidgetState extends State<AdminContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      width: 144,
      decoration: BoxDecoration(
        color: const Color(0XFFE4E4E4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 13,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
              style: TextStyle(fontSize: 20, color: Color(0XFF000000)),
            ),
            Text(
              'Admin',
              style: TextStyle(fontSize: 32, color: Color(0XFF000000)),
            )
          ],
        ),
      ),
    );
  }
}
