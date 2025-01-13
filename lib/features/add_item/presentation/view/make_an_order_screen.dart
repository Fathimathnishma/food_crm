import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/provider/item_provider.dart';
import 'package:food_crm/features/add_item/presentation/view/widget/order_item_add_row_widget.dart';
import 'package:food_crm/general/widgets/add_button_widget.dart';
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
      itemProvider.addItems();
    });
  }

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
      body: Consumer<ItemProvider>(
        builder: (context, stateItemAdd, child) {
          if (stateItemAdd.itemList.isEmpty) {
            return const Center(
              child: Text(
                'No orders available',
                style: TextStyle(color: ClrConstant.whiteColor),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: stateItemAdd.itemList.length,
              itemBuilder: (context, index) {
                final item = stateItemAdd.itemList[index];
                return OrderItemAddRowWidget(
                  onAdd: () {
                    stateItemAdd.addItems();
                  },
                  addItem: item,
                  onDelete: () {
                    stateItemAdd.removeItem(index);
                  },
                  isAdd: (index == (stateItemAdd.itemList.length - 1))
                      ? true
                      : false,
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AddButtonWidget(
          onTap: () async {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const OrderSummeryScreen(),
            //   ),
            // );
          },
          buttontext: 'Generate',
        ),
      ),
    );
  }
}
