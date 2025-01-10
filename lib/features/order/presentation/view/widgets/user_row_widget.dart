import 'package:flutter/material.dart';
class UserRowWidget extends StatelessWidget {
  final String initial;
  final String name;
  final num qty;
  final double amount;
  final int count;
  const UserRowWidget({
    super.key,
    required this.initial,
    required this.name,
    required this.qty,
    required this.amount,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: count,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              Image.asset('assets/images/trash.png'),
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 24,
                alignment: Alignment.center,
                child: Text(
                  qty.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '₹${amount.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          );
        },
      ),
    );
  }
}
