import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/provider/item_provider.dart';
import 'package:food_crm/features/order_summery/prsentation/view/order_summery_screen.dart';
import 'package:food_crm/general/widgets/add_button_widget.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_item_add_row_widget.dart';
import 'package:food_crm/features/order/presentation/view/widgets/order_item_delete_row_widget.dart';
import 'package:food_crm/general/utils/color_const.dart';
import 'package:provider/provider.dart';

class MakeAnOrderScreen extends StatefulWidget {
  const MakeAnOrderScreen({super.key});

  @override
  State<MakeAnOrderScreen> createState() => _MakeAnOrderScreenState();
}

class _MakeAnOrderScreenState extends State<MakeAnOrderScreen> {
  @override
  void initState() {
    super.initState();
    final itemProvider = Provider.of<ItemProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemProvider.fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

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
          Consumer<ItemProvider>(
            builder: (context, stateItemAdd, child) {
              if (stateItemAdd.localitemOrder.isEmpty) {
                return const Center(
                  child: Text(
                    'No orders available',
                    style: TextStyle(color: ClrConstant.whiteColor),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: stateItemAdd.localitemOrder.length,
                  itemBuilder: (context, index) {
                    final order = stateItemAdd.localitemOrder[index];
                    return OrderItemDeleteRowWidget(
                      itemName: order.item,
                      quantity: order.quantity.toInt(),
                      ratePerItem: order.price.toInt(),
                      onDelete: () {
                        stateItemAdd.removeOrderByIndex(
                          index,
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
          OrderItemAddRowWidget(
            onAdd: () {
              itemProvider.addOrderlocaly();
            },
          ),
        ],
      ),
      floatingActionButton: AddButtonWidget(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderSummeryScreen(),
            ),
          );
        },
        buttontext: 'Generate',
      ),
    );
  }
}
