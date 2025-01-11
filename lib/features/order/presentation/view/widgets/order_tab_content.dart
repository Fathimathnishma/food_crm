import 'package:flutter/material.dart';
import 'package:food_crm/features/item/data/model/item_model.dart';
import 'package:food_crm/features/order/presentation/view/widgets/user_row_widget.dart';

class OrderTabContent extends StatefulWidget {
  final ItemModel item;
  final int tabIndex;
  final Function(int tabIndex, int userIndex) onDelete;
  final Function(int tabIndex, int userIndex) controller;

  const OrderTabContent({
    super.key,
    required this.item,
    required this.tabIndex,
    required this.onDelete,
     required this.controller,
  });

  @override
  State<OrderTabContent> createState() => _OrderTabContentState();
}

class _OrderTabContentState extends State<OrderTabContent>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Call this to comply with AutomaticKeepAliveClientMixin

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.item.users.length,
            itemBuilder: (BuildContext context, int userIndex) {
              final user = widget.item.users[userIndex];
              return UserRowWidget(
                name: user.name,
                qty: widget.item.quantity,
                amount: widget.item.splitAmount,
                index: userIndex,
                tabIndex: widget.tabIndex,
                onDelete: widget.onDelete,
                controller: widget.controller
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true; // Ensures the widget's state is preserved
}
