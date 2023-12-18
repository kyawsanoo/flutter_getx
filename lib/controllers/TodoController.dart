import 'package:flutter/foundation.dart';
import 'package:flutter_getx/providers/TodoProvider.dart';
import 'package:flutter_getx/models/data.dart';
import 'package:get/get.dart';


class TodoController extends GetxController{
  final todoLoading = false.obs;
  List<Data>? todos;

  final TodoProvider todoProvider = Get.find();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAllTodos();
  }


  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}



  Future<void> getAllTodos() async {
    todoLoading.value = true;
    try {
      todos = await todoProvider.getAll();
      if (kDebugMode) {
        print("todos: ${todos?.first.toJson()}");
      }

    } finally {
      todoLoading.value = false;
    }
  }

}