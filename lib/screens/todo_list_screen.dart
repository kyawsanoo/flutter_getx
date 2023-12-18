import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx/constant/route_constant.dart';
import 'package:get/get.dart';

import '../controllers/TodoController.dart';
import '../models/data.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print('initState');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black87,
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Obx(() => todoController.todoLoading.value
              ? Center(
                  child: Container(
                    child: const CircularProgressIndicator(),
                  ),
                )
              : todoController.todos != null && todoController.todos!.isNotEmpty
                  ? RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: todoController.todos!.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Name: ${todoController.todos![index].todoName!}",
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "isComplete: ${todoController.todos![index].isComplete == null ? "not known" : todoController.todos![index].isComplete!}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                  title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ButtonTheme(
                                      minWidth: 100.0,
                                      height: 50.0,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          side: const BorderSide(
                                            color: Colors.black45,
                                          ),
                                        ),
                                        onPressed: () async {
                                          Get.toNamed(RouteConstant.editTodoScreen, arguments:{'todo': todoController.todos![index]});
                                        },
                                        child: const Text(
                                          "Edit",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ButtonTheme(
                                      minWidth: 100.0,
                                      //height: 50.0,
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.black,
                                          side: const BorderSide(
                                            color: Colors.black45,
                                          ),
                                        ),
                                        onPressed: () {
                                          openConfirmDialog(todoController.todos![index]);
                                        },
                                        child: const Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      )),
                                ],
                              ))
                            ],
                          ));
                        },
                      ))
                  : const Center(
                      child: Text("Todo list is empty and create new")))),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed(RouteConstant.createTodoScreen, arguments:{'title': 'Create Todo'});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _pullRefresh() async {
    final TodoController todoController = Get.put(TodoController());
    todoController.refreshTodoList();
  }

  Future<void> openConfirmDialog(Data todo) async {
    if (kDebugMode) {
      print("todo: ${todo.toJson()}");
    }
    final TodoController todoController = Get.put(TodoController());
    Get.dialog(
      AlertDialog(
        title: const Text('Confirm to delete'),
        content: const Text('Are you sure to delete?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),

          Obx(() {
            return todoController.todoLoading.value?
                const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),)
              :
                TextButton(
                  child: const Text("ok"),
                  onPressed: () async {
                    await todoController.delete(todo.todoId);
                    if(todoController.deletedTodo != null){
                      if (kDebugMode) {
                        print("deleted todo success");
                      }
                      Get.back();
                      Get.snackbar(
                        "Alert",
                        "Deleted todo successfully.",
                        colorText: Colors.black54,
                        backgroundColor: Colors.white,
                        icon: const Icon(Icons.add_alert),
                      );

                    }else{
                      if (kDebugMode) {
                        print("deleted todo failed");
                      }
                      Get.back();
                      Get.snackbar(
                        "Alert",
                        "Deleted todo Failed.",
                        colorText: Colors.black54,
                        backgroundColor: Colors.white,
                        icon: const Icon(Icons.add_alert),
                      );

              }

            },
          );
          }
          )
        ],
      ),
    );
  }
}
