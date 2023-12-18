import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx/controllers/TodoController.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../models/data.dart';

class EditTodoScreen extends StatefulWidget {

  const EditTodoScreen({super.key});

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();

}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final formKey = GlobalKey<FormState>();
  String? selectedValue;
  List<String> selectionList = ["true", "false"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final Data todo = ModalRoute.of(context)!.settings.arguments as Data;
    final Map<String, dynamic> args = Get.arguments;
    Data todo = args['todo'];
    final TodoController editTodoController = Get.put(TodoController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo", style: TextStyle(
          fontSize: 18,
          color: Colors.black87,
        ),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Form(
              key: formKey,
              child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 10,),
                const Text('isComplete', style: TextStyle(fontSize: 14,
                  color: Colors.black87,), ),
                const SizedBox(height: 10,),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.only(right: 10, left: 10),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 1, color: Colors.red),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  elevation: 1,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select';
                    } else {
                      return null;
                    }
                  },
                  isExpanded: true,
                  hint: const Text("Please select"),
                  iconSize: 45,
                  iconEnabledColor: Colors.black,
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 15,
                  ),
                  value: selectedValue,
                  items:
                  selectionList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: SizedBox( width: 200, child: Text( value,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      debugPrint("chosen value: $value");
                      selectedValue = value;
                    });
                  },
                ),
              ],)

            ),
          ),
          SizedBox(
              width: 200,
              child:
              Obx(() => editTodoController.todoLoading.value?
                    const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (kDebugMode) {
                            print("argument todo: ${todo.toJson()}");
                          }
                          final isValid = formKey.currentState!.validate();
                          if (!isValid) {
                            return;
                          } else {
                            debugPrint("validated: $isValid");
                            await editTodoController.updateTodo(
                                todo.todoId!, selectedValue == "true");
                            if(editTodoController.updatedTodo!=null){
                              if (kDebugMode) {
                                print("update todo success and updatedTodo is not null");
                              }
                              Get.snackbar(
                                "Alert",
                                "Updated todo successfully.",
                                colorText: Colors.black54,
                                backgroundColor: Colors.white,
                                icon: const Icon(Icons.add_alert),
                              );
                              await Future.delayed(const Duration(seconds: 1)).then((value) => Get.toNamed('/')
                              );
                            }else{
                              if (kDebugMode) {
                                print("update todo failed and updatedTodo is null");
                              }
                              Get.snackbar(
                                "Alert",
                                "Updated todo failed.",
                                colorText: Colors.black54,
                                backgroundColor: Colors.white,
                                icon: const Icon(Icons.add_alert),
                              );
                              Get.toNamed('/');
                            }
                          }
                        },
                        child: const Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ))
              )
          )
        ],
      ),
    );
  }
}
