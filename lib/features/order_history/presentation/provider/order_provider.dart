
// import 'package:flutter/widgets.dart';
// import 'package:food_crm/features/order_history/data/model/i_order_facade.dart';


// class OrderProvider with ChangeNotifier {
//   final IOrderFacade iOrderFacade;
//   OrderProvider( this.iOrderFacade);

  
//   bool isLoading = false;
//   bool noMoreData = false;









// // Future<void> addOrders() async {
// //   if (localorder.isEmpty) {
// //     log("No orders to submit");
// //     return;
// //   }


// //   total = 0;
// //   for (var order in localorder) {
// //     total += order.price;
// //   }
// //   log("Total: $total");

 
// //   final orderMaps = localorder.map((order) => order.toMap()).toList();
// //   final result = await iOrderFacade.addOrderList(
// //     ordermodel: ServiceOrderModel(
// //       createdAt: Timestamp.now(),
// //       orders: orderMaps,
// //     ),
// //   );

// //   result.fold(
// //     (failure) => log("Failed to add orders: ${failure.toString()}"),
// //     (_) {
// //       log("Orders added successfully to services");
// //       localorder.clear(); 
// //     },
// //   );

// //   notifyListeners();
// // }


//   // Future<void> fetchOrders() async {
//   //   if (isLoading || noMoreData) return;
//   //   isLoading = true;
//   //   notifyListeners();
//   //   final result = await iOrderFacade.fetchOrders();

//   //   result.fold(
//   //     (failure) {
//   //       log(failure.errormsg);
//   //     },
//   //     (success) {

//   //       log('Ordrt fetched');
//   //     },
//   //   );
//   //   isLoading = false;
//   //   notifyListeners();
//   // }




// }
