import 'dart:async';
import 'dart:io';

import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:get/get_connect/http/src/response/response.dart';
String getErrorMsg(dynamic obj) {
  if (obj is GetHttpException) {
    return obj.message;
  } else if (obj is SocketException || obj is TimeoutException) {
    return "No Internet connection or request timed out";
  } else if (obj is Response) {
    final status = obj.status;

    if (status.connectionError) {
      return "No internet connection";
    } else if (status.isUnauthorized) {
      return obj.statusText ?? "Unauthorized";
    } else if (status.isNotFound) {
      return "404: Resource not found";
    } else if (status.isServerError) {
      return "${status.code}: Server error. Please try again later.";
    }

    try {
      // Check if body has message
      if (obj.body != null && obj.body is Map<String, dynamic>) {
        return obj.body["responseText"] ??
            obj.body["message"] ??
            "${obj.statusCode ?? 'Unknown status'}\n${obj.statusText ?? 'Unknown error'}";
      }
      return "${obj.statusCode ?? 'Unknown status'}\n${obj.statusText ?? 'Unknown error'}";
    } catch (e) {
      return "Something went wrong";
    }
  } else {
    return "Unexpected error occurred";
  }
}
