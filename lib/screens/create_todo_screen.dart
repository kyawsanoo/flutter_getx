import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/TodoController.dart';
import '../models/data.dart';


class CreateTodoScreen extends StatefulWidget {

  const CreateTodoScreen({super.key});

  @override
  State<CreateTodoScreen> createState() => _CreateTodoScreenState();

}

class _CreateTodoScreenState extends State<CreateTodoScreen> {
  // declare a GlobalKey
  final _formKey = GlobalKey<FormState>();
  // declare a variable to keep track of the input text
  String _name = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      //final Map<String, dynamic> args = Get.arguments;
      //String title = args['tile'];
      final TodoController todoController = Get.put(TodoController());
      return Scaffold(
          appBar: AppBar(
            title: Text("Create New", style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),),
          ),
          body: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 30),
              child:
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Enter todo name',
                      ),
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';
                        }
                        if (text.length < 4) {
                          return 'Too short';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() => _name = text),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(width: 200,
                      child:
                      Obx(
                              () => todoController.todoLoading.value?
                                  Center(
                                    child: Container(
                                      child: const CircularProgressIndicator(),
                                    ),
                                  )
                                      :
                                  ElevatedButton(
                                        onPressed: _name.isNotEmpty ? _submit : null,
                                        child: Text(
                                        'Create',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyMedium,
                                        ),
                                    )
                                  )
                    )
                    ],
                ),
              )

          )

      );

  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final TodoController todoController = Get.put(TodoController());

      await todoController.createNewTodo( _name);
      Data? createdTod = todoController.createdTodo;
      if (createdTod !=null) {
        if (kDebugMode) {
          print("createdTodo success and it is not null");
        }
        Get.snackbar(
          "Alert",
          "Created todo successfully.",
          colorText: Colors.black54,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.add_alert),
        );
        await Future.delayed(const Duration(seconds: 1)).then((value) => Get.toNamed('/')
        );

      }else{
        if (kDebugMode) {
          print("createdTodo is null");
        }
        Get.snackbar(
          "Alert",
          "Created todo failed.",
          colorText: Colors.black54,
          backgroundColor: Colors.white,
          icon: const Icon(Icons.add_alert),
        );
        await Future.delayed(const Duration(seconds: 1)).then((value) => Get.toNamed('/')
        );
      }
    }
  }


}
