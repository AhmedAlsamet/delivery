import 'package:dio/dio.dart';
import 'package:emarket_delivery_boy/data/datasource/remote/dio/dio_client.dart';
import 'package:emarket_delivery_boy/data/datasource/remote/exception/api_error_handler.dart';
import 'package:emarket_delivery_boy/commons/models/api_response.dart';
import 'package:emarket_delivery_boy/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;

  OrderRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getAllOrders() async {
    try {
      final response = await dioClient!.get('${AppConstants.currentOrdersUri}${sharedPreferences!.get(AppConstants.token)}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderDetails({String? orderID}) async {
    try {
      final response = await dioClient!.get('${AppConstants.orderDetailsUri}${sharedPreferences!.get(AppConstants.token)}&order_id=$orderID');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getAllOrderHistory() async {
    try {
      final response = await dioClient!.get('${AppConstants.orderHistoryUri}${sharedPreferences!.get(AppConstants.token)}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateOrderStatus({String? token, int? orderId, String? status}) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updateOrderStatusUri,
        data: {"token": token, "order_id": orderId, "status": status, "_method": 'put'},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> updatePaymentStatus({String? token, int? orderId, String? status}) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.updatePaymentStatusUri,
        data: {"token": token, "order_id": orderId, "status": status, "_method": 'put'},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getOrderModel(String orderId) async {
    try {
      final response = await dioClient!.get('${AppConstants.getOrderModel}${sharedPreferences!.get(AppConstants.token)}&id=$orderId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
