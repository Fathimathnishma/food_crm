import 'package:flutter/material.dart';
import 'package:food_crm/features/order_details/data/i_order_details_facade.dart';
import 'package:food_crm/features/order_summery/data/model/item_uploading%20_model.dart';
import 'package:food_crm/features/order_summery/data/model/order_model.dart';

class OrderDetailsProvider extends ChangeNotifier {
 final IOrderDetailsFacade iOrderDetailsFacade;
  OrderDetailsProvider(this.iOrderDetailsFacade);


OrderModel? order ;
final List<ItemUploadingModel>itemsList=[];
num totalAmount =0;
bool isLoading=false;
String foodTime='';

  Future<void> fetchOrderById({required String orderId})async{


    final result = await iOrderDetailsFacade.fetchOrderbyId(orderId: orderId);
    result.fold((l) {
      l.toString();
    }, (r) {
      order=r;
       if (order != null) {
          itemsList.clear();
          itemsList.addAll(order!.order); 
        totalAmount=order!.totalAmount;
        foodTime= order!.foodTime;
      }
    notifyListeners();
    },);
  }


}