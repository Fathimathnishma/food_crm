import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/features/add_item/presentation/view/widget/order_item_add_row_widget.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/custom_button.dart';
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
    final itemProvider = Provider.of<AddItemProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      itemProvider.addItem();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor,
        title: const Text(
          'Make An Order',
          style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
        ),
      ),
      body: Consumer<AddItemProvider>(
        builder: (context, stateItemAdd, child) {
          if (stateItemAdd.itemList.isEmpty) {
            return const Center(
              child: Text(
                'No orders available',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: stateItemAdd.itemList.length,
              itemBuilder: (context, index) {
                final item = stateItemAdd.itemList[index];
                return OrderItemAddRowWidget(
                  onAdd: () {
                    stateItemAdd.addItem();
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
        child: CustomButton(
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
