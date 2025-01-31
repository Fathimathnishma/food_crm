import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/features/add_item/presentation/view/widget/order_item_add_widget.dart';
import 'package:food_crm/features/order_summery/prsentation/view/order_summery_screen.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:food_crm/general/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final addItemProvider = context.read<AddItemProvider>();
        // FETCH SUGGESTION
        if (addItemProvider.itemsuggestionList.isEmpty) {
          addItemProvider.fetchSugetion();
        }
        //
        if (addItemProvider.itemList.isEmpty) {
          addItemProvider.addItem();
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddItemProvider>(builder: (context, itemProvider, _) {
      return Scaffold(
        backgroundColor: AppColors.blackColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.blackColor,
          title: const Text(
            'Make An Order',
            style: TextStyle(fontSize: 18, color: AppColors.whiteColor),
          ),
        ),
        body: itemProvider.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 2,
                ),
              )
            : ListView.builder(
                itemCount: itemProvider.itemList.length,
                itemBuilder: (context, index) {
                  return OrderItemAddWidget(
                    itemModel: itemProvider.itemList[index],
                    onAdd: () {
                      itemProvider.addItem();
                    },
                    onRemove: () {
                      itemProvider.removeItem(index);
                    },
                    isAdd: (index == (itemProvider.itemList.length - 1))
                        ? true
                        : false,
                  );
                },
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            right: 12,
            left: 12,
            bottom: 12,
          ),
          child: CustomButton(
            onTap: () async {
              itemProvider.addSuggestions(onSuccess: () {
                
              },);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderSummeryScreen(itemList: itemProvider.itemList),
                  ));
            },
            buttontext: 'Generate',
            color: AppColors.primaryColor,
            textColor: AppColors.blackColor,
           
          ),
        ),
      );
      });
 }
}
