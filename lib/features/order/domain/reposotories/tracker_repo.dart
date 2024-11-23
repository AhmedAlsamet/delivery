
import 'package:dio/dio.dart';
import 'package:emarket_delivery_boy/data/datasource/remote/dio/dio_client.dart';
import 'package:emarket_delivery_boy/data/datasource/remote/exception/api_error_handler.dart';
import 'package:emarket_delivery_boy/features/order/domain/models/track_data_model.dart';
import 'package:emarket_delivery_boy/commons/models/api_response.dart';
import 'package:emarket_delivery_boy/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackerRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  TrackerRepo({required this.dioClient, required this.sharedPreferences});


  Future<ApiResponse> addHistory(TrackDataModel trackBody) async {
    try {
      Response response = await dioClient!.post(AppConstants.recordLocationUri, data: trackBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}