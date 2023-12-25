import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_getx/models/todolist_api_response.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';

import '../models/data.dart';

class TodoProvider extends GetConnect {

  @override
  void onInit() {
    httpClient.baseUrl = 'https://dummyjson.com';
  }

  Future<List<Data>?> getAllTodosApiRequest() async {
    Response response = await get('/todos');
    if(response.statusCode == 200) {
      TodoListApiResponse todoListApiResponse = TodoListApiResponse.fromJson(response.body);
      if (kDebugMode) {
        print("response: $response");
        print("TodoListApiResponse: ${todoListApiResponse.toJson()}");
      }
      return todoListApiResponse.data;
    }else{
      return null;
    }
  }

  Future<Data?> createTodoApiRequest(String todoName) async {
    if (kDebugMode) {
      print('CreateTodo Api Call Starting todoName: $todoName');
    }
    dynamic body = jsonEncode({
      "todo": todoName,
      "completed":false,
      "userId":1
    });
    dynamic header = {"Content-Type": "application/json"};
    if (kDebugMode) {
      print('CreateTodo Api Request Body $body');
    }
    Response response = await post('/todos/add', body,
        headers: header);

      if (response.statusCode == 200) {
        // final responseBody = json.decode(response.body);
        if (kDebugMode) {
          print('CreateTodo Api Response Body: ${response.body}');
        }
        Data todo = Data.fromJson(response.body);
        if (kDebugMode) {
          print('todo: ${todo.toJson()}');
        }
        return todo;
      } else {
        if (kDebugMode) {
          print('Create todo api call Error Occurred ${response.hasError
              ? response.statusCode
              : ""}');
        }
      }
    return null;
  }

  Future<Data?> updateTodoApiRequest(int todoId, bool completed) async {
    if (kDebugMode) {
      print('UpdateTodo Api Call Starting todoId: $todoId completed: $completed');
    }
    dynamic body = jsonEncode({
      "completed": completed,
    });
    dynamic header = {"Content-Type": "application/json"};
    if (kDebugMode) {
      print('UpdateTodo Api Request Body $body');
    }
    Response response = await put('/todos/$todoId', body,
        headers: header);

    if (response.statusCode == 200) {
      // final responseBody = json.decode(response.body);
      if (kDebugMode) {
        print('UpdateTodo Api Response Body: ${response.body}');
      }
      Data todo = Data.fromJson(response.body);
      if (kDebugMode) {
        print('todo: ${todo.toJson()}');
      }
      return todo;
    } else {
      if (kDebugMode) {
        print('Update todo api call Error Occurred ${response.hasError
            ? response.statusCode
            : ""}');
      }
    }
    return null;
  }

  Future<Data?> deleteTodoApiRequest(int todoId) async {
    if (kDebugMode) {
      print('DeleteTodo Api Call Starting todoId: $todoId');
    }
    dynamic header = {"Content-Type": "application/json"};

    Response response = await delete('/todos/$todoId',
        headers: header);

    if (response.statusCode == 200) {
      // final responseBody = json.decode(response.body);
      if (kDebugMode) {
        print('Delete Todo Api Response Body: ${response.body}');
      }
      Data todo = Data.fromJson(response.body);
      if (kDebugMode) {
        print('todo: ${todo.toJson()}');
      }
      return todo;
    } else {
      if (kDebugMode) {
        print('Delete todo api call Error Occurred ${response.hasError
            ? response.statusCode
            : ""}');
      }
    }
    return null;
  }
}
