import 'package:flutter/material.dart';
import 'package:food_crm/features/order/presentation/provider/order_provider.dart';
import 'package:food_crm/features/order/presentation/view/order_summery_screen.dart';
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
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderProvider.fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

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
          Consumer<OrderProvider>(
            builder: (context, orderPro, child) {
              if (orderPro.isLoading && orderPro.orderList.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (orderPro.orderList.isEmpty) {
                return const Center(
                  child: Text('No orders available'),
                );
              } else {
                return ListView.builder(
                    itemCount: orderPro.orderList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final order = orderPro.orderList[index];
                      return OrderItemDeleteRowWidget(
                          itemName: order.item,
                          quantity: order.quantity.toInt(),
                          ratePerItem: order.price.toInt(),
                          onDelete: () {
                            orderPro.deleteOrder(orderId: order.id!);
                          });
                    });
              }
            },
          ),
          OrderItemAddRowWidget(
            onAdd: () {
              orderProvider.addOrder();
            },
          ),
        ],
      ),
      floatingActionButton: AddButtonWidget(
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
