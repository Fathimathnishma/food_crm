import 'package:flutter/material.dart';

class AlertDialogWidget extends StatefulWidget {
  final String label1;
  final String label2;
  final Future<void> Function() onLabel2Tap;

  const AlertDialogWidget({
    super.key,
    required this.label1,
    required this.label2,
    required this.onLabel2Tap,
  });

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  bool _isLoading = false;

  Future<void> _handleLabel2Tap() async {
    setState(() {
      _isLoading = true;
    });
    try {
     
      await widget.onLabel2Tap();
    } finally {
      setState(() {
        _isLoading = false;
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Are you sure you want to ${widget.label1}?',
        style: const TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            if (!_isLoading) {
              Navigator.of(context).pop();
            }
          },
          child: const Text("Cancel"),
        ),
        _isLoading
            ? const Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              )
            : InkWell(
                onTap: _handleLabel2Tap,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    widget.label2,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
      ],
    );
  }
}

void showCustomDialog(
  BuildContext context,
  String label1,
  String label2,
  Future<void> Function() onLabel2Tap,
) {
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
