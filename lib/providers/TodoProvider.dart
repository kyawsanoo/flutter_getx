import 'package:flutter/foundation.dart';
import 'package:flutter_getx/models/todolist_api_response.dart';
import 'package:get/get_connect/connect.dart';

import '../models/data.dart';

class TodoProvider extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = 'https://dummyjson.com';
  }

  Future<List<Data>?> getAll() async {
    Response response = await get('/todos');
    if(response.statusCode == 200) {
      TodoListApiResponse todoListApiResponse = TodoListApiResponse.fromJson(response.body);
      if (kDebugMode) {
        print("response: ${response}");
        print("TodoListApiResponse: ${todoListApiResponse.toJson()}");
      }
      return todoListApiResponse.data;
    }else{
      return null;
    }
  }
}
