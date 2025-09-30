
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';
import '../utils/printer.dart';


class GetConnectApiClient extends GetConnect with Printer{
  GetConnectApiClient._(){
    onInit();
  }
  static GetConnectApiClient? _instance;

  static GetConnectApiClient get instance{
    if(_instance != null){
      return _instance!;
    }else{
      _instance =GetConnectApiClient._();
      return _instance!;
    }
  }
  @override
  void onInit(){
    httpClient.baseUrl = baseUrls;
    httpClient.defaultContentType ="application/json";
    httpClient.timeout = const Duration(seconds: 30);

    // Request logging
    httpClient.addRequestModifier<dynamic>((request){

      if(kDebugMode){
        printRequest(request);
      }
      return request;
    });

    // Response logging
    httpClient.addResponseModifier((request, response){
      if(kDebugMode){
        printResponse(response, request);
      }
      return response;
    });
    super.onInit();
  }
  // API methods
  Future<Response> getProducts()async{
    return await get('/products');
  }

}