import 'dart:developer';

import 'package:get/get.dart';
import 'package:graph_ql/model/APIs/api_response.dart';
import 'package:graph_ql/model/services/services.dart';

class GraphController extends GetxController {
  var apiResponse = ApiResponse.initial().obs;
  Services services = Services();
  List<dynamic> results = [];

  getData() async {
    apiResponse.value = ApiResponse.loading();
    await Future.delayed(const Duration(seconds: 5));
    apiResponse.value = await services.getResponse();
    log(apiResponse.value.data.toString());
    results = apiResponse.value.data['users'];
    log('${apiResponse.value.status == Status.completed}');
    log(' ------------------------>      the list is $results');
  }
}
