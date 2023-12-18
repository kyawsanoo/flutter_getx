import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/TodoController.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
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
                                          /*await  Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => const EditScreen(),
                                            settings: RouteSettings(
                                              arguments: todos[index],
                                            ),
                                          )
                                          ).then((isCompleteUpdated){
                                            if (kDebugMode) {
                                              print('isCompleteUpdated: $isCompleteUpdated');
                                            }
                                            if(isCompleteUpdated!=null && isCompleteUpdated){
                                              //refresh the page
                                              _pullRefresh();
                                            }
                                           });*/
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
                                          /*_dialogBuilder(context, todos[index]);*/
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
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {});
  }

/*Future<void> _dialogBuilder(BuildContext context, Data todo) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return
          ScaffoldMessenger(child: Builder(builder: (context){
          return Scaffold(
            backgroundColor: Colors.transparent,
              body: AlertDialog(
            title: const Text('Confirm to delete'),
            content: const Text(
                'Are you sure to delete?'

            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),

              Consumer<DataProvider>(builder: (context, dataProvider, child) {
                return
                  dataProvider.loading ?
                  SizedBox(width: 20, height: 20, child: CircularProgressIndicator(),)

                      :
                  TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme
                            .of(context)
                            .textTheme
                            .labelLarge,
                      ),
                      child: const Text('Ok'),
                      onPressed: () async {
                        var dataProvider = Provider.of<DataProvider>(
                            context, listen: false);
                        await dataProvider.callDeleteTodoApi(this, todo.todoId);
                        if (dataProvider.isBack){
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Deleted successfully."),
                              )
                          );
                          await Future.delayed(const Duration(seconds: 1)).then((value) =>
                              Navigator.of(context).pop()
                          ).then((value){_pullRefresh();});
                        }

                      }
                  );
              })
            ],
          ));

        }));
      },
    );
  }
*/
}
