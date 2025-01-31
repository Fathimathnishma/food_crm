import 'package:flutter/material.dart';
import 'package:food_crm/features/add_item/data/model/item_model.dart';
import 'package:food_crm/features/add_item/presentation/provider/add_item_provider.dart';
import 'package:food_crm/general/utils/app_colors.dart';
import 'package:provider/provider.dart';

class OrderItemAddWidget extends StatefulWidget {
  final ItemAddingModel itemModel;
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
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode quantityFocusNode = FocusNode();
  final FocusNode priceFocusNode = FocusNode();

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
                  flex: 2, // Adjust space for the item name field
                  child: Autocomplete<ItemAddingModel>(
                    initialValue:
                        TextEditingValue(text: widget.itemModel.name.text),
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<ItemAddingModel>.empty();
                      } else {
                        return addItemProvider.itemsuggestionList.where(
                          (element) => element.name.text.toLowerCase().contains(
                                textEditingValue.text.toLowerCase(),
                              ),
                        );
                      }
                    },
                    displayStringForOption: (ItemAddingModel option) =>
                        option.name.text,
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController controller,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      if (controller.text != widget.itemModel.name.text) {
                        controller.text = widget.itemModel.name.text;
                      }

                      return TextField(
                        controller: controller,
                        onChanged: (value) {
                          widget.itemModel.name.text = value;
                          setState(() {});
                        },
                        focusNode: nameFocusNode,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Item Name', // Show label on focus
                          labelStyle: TextStyle(
                            color: nameFocusNode.hasFocus
                                ? Colors.white
                                : Colors.grey,
                          ),
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
                        AutocompleteOnSelected<ItemAddingModel> onSelected,
                        Iterable<ItemAddingModel> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 200,
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
                    onSelected: (ItemAddingModel selectedOption) {
                      widget.itemModel.name.text = selectedOption.name.text;
                      widget.itemModel.quantity.text =
                          selectedOption.quantity.text;
                      widget.itemModel.price.text = selectedOption.price.text;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1, // Adjust space for the quantity input
                  child: SizedBox(
                    width: 50,
                    child: TextField(
                      controller: widget.itemModel.quantity,
                      focusNode: quantityFocusNode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Qty',
                        labelStyle: TextStyle(
                          color: quantityFocusNode.hasFocus
                              ? AppColors.whiteColor
                              : Colors.grey,
                        ),
                        hintText: 'Qty',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1, // Adjust space for the price input
                  child: SizedBox(
                    width: 80,
                    child: TextField(
                      controller: widget.itemModel.price,
                      focusNode: priceFocusNode,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Price',
                        labelStyle: TextStyle(
                          color: priceFocusNode.hasFocus
                              ? AppColors.whiteColor
                              : Colors.grey,
                        ),
                        hintText: 'Price',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor:
                      widget.isAdd ? const Color(0XFF1FAF38) : Colors.red,
                  radius: 15,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      widget.isAdd ? Icons.add : Icons.close,
                      color: AppColors.whiteColor,
                      size: 24,
                    ),
                    onPressed: widget.isAdd ? widget.onAdd : widget.onRemove,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
