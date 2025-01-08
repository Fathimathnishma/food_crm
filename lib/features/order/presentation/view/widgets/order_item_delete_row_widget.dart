// import 'package:flutter/material.dart';
// import 'package:food_crm/general/utils/color_const.dart';

// class OrderItemDeleteRowWidget extends StatelessWidget {
//   final TextEditingController itemNameController;
//   final TextEditingController quantityController;
//   final TextEditingController rateController;
//   final VoidCallback onDelete;

//   const OrderItemDeleteRowWidget({
//     super.key,
//     required this.itemNameController,
//     required this.quantityController,
//     required this.rateController,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: itemNameController,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//               decoration: InputDecoration(
//                 prefixIcon: Padding(
//                   padding:
//                       const EdgeInsets.all(8.0),
//                   child: Image.asset(
//                     'assets/images/check-list.png',
//                     height: 24,
//                     width: 24,
//                   ),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
//                 hintText: 'Item Name',
//                 hintStyle: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 50,
//             child: TextField(
//               controller: quantityController,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Qty',
//                 hintStyle: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 80,
//             child: TextField(
//               controller: rateController,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//               keyboardType:
//                   const TextInputType.numberWithOptions(decimal: true),
//               decoration: const InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Rate',
//                 hintStyle: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ),
//           CircleAvatar(
//             backgroundColor: Colors.red,
//             radius: 15,
//             child: IconButton(
//               padding: EdgeInsets.zero,
//               icon: const Icon(
//                 Icons.close,
//                 size: 24,
//                 color: ClrConstant.whiteColor,
//               ),
//               onPressed: onDelete,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_crm/general/utils/color_const.dart';

class OrderItemDeleteRowWidget extends StatelessWidget {
  final String itemName;
  final int quantity;
  final double ratePerItem;
  final VoidCallback onDelete;

  const OrderItemDeleteRowWidget({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.ratePerItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset('assets/images/check-list.png', height: 24, width: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              itemName,
              style: const TextStyle(
                  color: ClrConstant.whiteColor,
                  fontSize: 16,
                  decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              ratePerItem.toStringAsFixed(2),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 15,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.close,
                size: 24,
                color: ClrConstant.whiteColor,
              ),
              onPressed: onDelete,
            ),
          ),
        ],
      ),
    );
  }
}
