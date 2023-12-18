import 'package:flutter/foundation.dart';
import 'package:flutter_getx/providers/TodoProvider.dart';
import 'package:flutter_getx/models/data.dart';
import 'package:get/get.dart';

class TodoController extends GetxController{
  final todoLoading = false.obs;
  List<Data>? todos;
  Data? createdTodo;
  Data? deletedTodo;
  Data? updatedTodo;

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
      todos = await todoProvider.getAllTodosApiRequest();
      if (kDebugMode) {
        print("todos: ${todos?.first.toJson()}");
      }

    } finally {
      todoLoading.value = false;
    }
  }

  Future<void> createNewTodo(todoName) async {
    todoLoading.value = true;
    try {
      createdTodo = await todoProvider.createTodoApiRequest(todoName);
      if (kDebugMode) {
        print("todo: ${createdTodo?.toJson()}");
      }

    } finally {
      todoLoading.value = false;
    }
  }

  Future<void> updateTodo(int todoId, bool completed) async {
    todoLoading.value = true;
    try {
      updatedTodo = await todoProvider.updateTodoApiRequest(todoId, completed);
      if (kDebugMode) {
        print("todo: ${updatedTodo?.toJson()}");
      }

    } finally {
      todoLoading.value = false;
    }
  }


  Future<void> delete(todoName) async {
    todoLoading.value = true;
    try {
      deletedTodo = await todoProvider.deleteTodoApiRequest(todoName);
      if (kDebugMode) {
        print("todo: ${deletedTodo?.toJson()}");
      }

    } finally {
      todoLoading.value = false;
    }
  }


  Future<void> refreshTodoList() async {
    getAllTodos();
  }

}