import 'dart:async';
import 'package:emarket_delivery_boy/helper/custom_snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:emarket_delivery_boy/commons/models/api_response.dart';
import 'package:emarket_delivery_boy/features/order/domain/models/order_details_model.dart';
import 'package:emarket_delivery_boy/features/order/domain/models/order_model.dart';
import 'package:emarket_delivery_boy/features/order/domain/reposotories/order_repo.dart';
import 'package:emarket_delivery_boy/commons/models/response_model.dart';
import 'package:emarket_delivery_boy/helper/api_checker_helper.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepo? orderRepo;

  OrderProvider({required this.orderRepo});

  List<OrderModel>? _currentOrders;
  List<OrderModel> _currentOrdersReverse = [];
  bool _isLoading = false;
  List<OrderModel>? _allOrderHistory;
  late List<OrderModel> _allOrderReverse;
  List<OrderDetailsModel>? _orderDetails;

  List<OrderModel>? get currentOrders => _currentOrders;
  bool get isLoading => _isLoading;
  List<OrderModel>? get allOrderHistory => _allOrderHistory;
  List<OrderDetailsModel>? get orderDetails => _orderDetails;


  Future getAllOrders() async {
    ApiResponse apiResponse = await orderRepo!.getAllOrders();

    if (apiResponse.response?.statusCode == 200) {
      _currentOrders = [];
      _currentOrdersReverse = [];

      apiResponse.response?.data.forEach((order) {
        _currentOrdersReverse.add(OrderModel.fromJson(order));
      });

      _currentOrders = List.from(_currentOrdersReverse.reversed);

    } else {
      ApiCheckerHelper.checkApi(apiResponse);

    }
    notifyListeners();
  }


  Future<List<OrderDetailsModel>?> getOrderDetails(String orderID) async {
    _orderDetails = null;
    ApiResponse apiResponse = await orderRepo!.getOrderDetails(orderID: orderID);

    if (apiResponse.response?.statusCode == 200) {
      _orderDetails = [];
      apiResponse.response!.data.forEach((orderDetail) => _orderDetails!.add(OrderDetailsModel.fromJson(orderDetail)));

    } else {
      ApiCheckerHelper.checkApi(apiResponse);

    }

    notifyListeners();
    return _orderDetails;
  }

  // get all order history


  Future<List<OrderModel>?> getOrderHistory() async {
    ApiResponse apiResponse = await orderRepo!.getAllOrderHistory();

    if (apiResponse.response!.statusCode == 200) {
      _allOrderHistory = [];
      _allOrderReverse = [];

      apiResponse.response!.data.forEach((orderDetail) => _allOrderReverse.add(OrderModel.fromJson(orderDetail)));

      _allOrderHistory = List.from(_allOrderReverse.reversed);

    } else {
      ApiCheckerHelper.checkApi(apiResponse);

    }

    notifyListeners();
    return _allOrderHistory;
  }

  // update Order Status



  Future<ResponseModel> updateOrderStatus({String? token, int? orderId, String? status}) async {
    _isLoading = true;
    notifyListeners();

    ApiResponse apiResponse = await orderRepo!.updateOrderStatus(token: token, orderId: orderId, status: status);
    _isLoading = false;
    notifyListeners();

    ResponseModel responseModel;

    if (apiResponse.response?.statusCode == 200) {
      responseModel = ResponseModel(apiResponse.response?.data['message'], true);
    } else {

      String? feedbackMessage = ApiCheckerHelper.getError(apiResponse).errors?[0].message;
      showCustomSnackBar(feedbackMessage ?? '');
      responseModel = ResponseModel(feedbackMessage, false);
    }

    notifyListeners();
    return responseModel;
  }

  Future updatePaymentStatus({String? token, int? orderId, String? status}) async {
    await orderRepo!.updatePaymentStatus(token: token, orderId: orderId, status: status);

    notifyListeners();
  }

  Future<void> refresh() async{
    _isLoading = true;
    notifyListeners();
    await getAllOrders();
    await getOrderHistory();
    _isLoading = false;
    notifyListeners();
  }

  Future<OrderModel?> getOrderModel(String orderID) async {
   OrderModel? currentOrderModel;

    ApiResponse apiResponse = await orderRepo!.getOrderModel(orderID);

    if (apiResponse.response?.statusCode == 200) {
      currentOrderModel = OrderModel.fromJson(apiResponse.response!.data);

    } else {
      ApiCheckerHelper.checkApi(apiResponse);

    }

    notifyListeners();
    return currentOrderModel;
  }
}
