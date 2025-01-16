// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class OrderItemAddWidget extends StatefulWidget {
  final ItemUploadingModel itemModel;
  final bool isAdd;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const OrderItemAddWidget({
    super.key,
    required this.itemModel,
    required this.isAdd,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<OrderItemAddWidget> createState() => _OrderItemAddWidgetState();
}

class _OrderItemAddWidgetState extends State<OrderItemAddWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddItemProvider>(builder: (context, addItemProvider, _) {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Autocomplete<ItemUploadingModel>(
                  initialValue:
                      TextEditingValue(text: widget.itemModel.name.text),
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<ItemUploadingModel>.empty();
                    } else {
                      return addItemProvider.itemsuggestionList.where(
                        (element) => element.name.text.toLowerCase().contains(
                              textEditingValue.text.toLowerCase(),
                            ),
                      );
                    }
                  },
                  displayStringForOption: (ItemUploadingModel option) =>
                      option.name.text,
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController controller,
                      FocusNode focusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: controller, // Use the Autocomplete controller

                      onChanged: (value) {
                        widget.itemModel.name.text = value;
                        setState(() {
                          
                        });
                      },
                      focusNode: focusNode,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/images/check-list.png',
                          height: 24,
                          width: 24,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12.0),
                        hintText: 'Item Name',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      onEditingComplete: onFieldSubmitted,
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<ItemUploadingModel> onSelected,
                      Iterable<ItemUploadingModel> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          height: 200, // Customize height as needed
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final option = options.elementAt(index);
                              return ListTile(
                                title: Text(
                                  option.name.text,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (ItemUploadingModel selectedOption) {
                    // Update the TextField value and perform any actions on selection
                    widget.itemModel.name.text = selectedOption.name.text;
                    widget.itemModel.quantity.text =
                        selectedOption.quantity.text;
                    widget.itemModel.price.text = selectedOption.price.text;
                    setState(() {});
                  },
                )),
                const SizedBox(width: 8),
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: widget.itemModel.quantity,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Qty',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: widget.itemModel.price,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'per rate',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                if (widget.isAdd)
                  CircleAvatar(
                    backgroundColor: const Color(0XFF1FAF38),
                    radius: 15,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                        size: 24,
                      ),
                      onPressed: widget.onAdd,
                    ),
                  )
                else
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 15,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.whiteColor,
                        size: 24,
                      ),
                      onPressed: widget.onRemove,
                    ),
                  )
              ],
            ),
          ],
        ),
      );
    });
  }
}
