import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String label1;
  final String label2;
  final VoidCallback onLabel2Tap; // Callback for when label2 is tapped

  const AlertDialogWidget({super.key, 
    required this.label1,
    required this.label2,
    required this.onLabel2Tap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Are you sure you want to $label1?',
        style: const TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
       
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
          },
          child: const Text("Cancel"),
        ),
        
        InkWell(
          onTap: onLabel2Tap, 
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              label2,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

// 
void showCustomDialog(BuildContext context, String label1, String label2, VoidCallback onLabel2Tap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialogWidget(
        label1: label1,
        label2: label2,
        onLabel2Tap: onLabel2Tap, 
      );
    },
  );
}
