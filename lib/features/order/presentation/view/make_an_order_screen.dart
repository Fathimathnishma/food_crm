import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/view/order_summery_screen.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_add_button_widget.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_item_add_row_widget.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_item_delete_row_widget.dart';
import 'package:food_crm/general/utils/color_const.dart';

class MakeAnOrderScreen extends StatefulWidget {
  const MakeAnOrderScreen({super.key});

  @override
  State<MakeAnOrderScreen> createState() => _MakeAnOrderScreenState();
}

class _MakeAnOrderScreenState extends State<MakeAnOrderScreen> {
  TextEditingController itemController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ClrConstant.blackColor,
      appBar: AppBar(
        backgroundColor: ClrConstant.blackColor,
        title: const Text(
          'Make An Order',
          style: TextStyle(fontSize: 18, color: ClrConstant.whiteColor),
        ),
      ),
      body: Column(
        children: [
          OrderItemDeleteRowWidget(
              itemName: 'Chapathi',
              quantity: 2,
              ratePerItem: 200,
              onDelete: () {}),
          OrderItemAddRowWidget(
            onAdd: () {},
            itemController: itemController,
            priceController: rateController,
            qtyController: qtyController,
          )
        ],
      ),
      floatingActionButton: OrderAddButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderSummeryScreen(),
                ));
          },
          buttontext: 'generate'),
    );
  }
}
