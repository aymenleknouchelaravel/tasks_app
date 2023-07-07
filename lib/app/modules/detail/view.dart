import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/util/extensions.dart';
import 'package:todo/app/modules/detail/widgets/doing_list.dart';
import 'package:todo/app/modules/detail/widgets/done_list.dart';
import '../home/controller.dart';

class Details extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  Details({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value;
    final color = HexColor.fromHex(task!.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      homeCtrl.updateTodos();
                      homeCtrl.changeTask(null);
                      homeCtrl.editController.clear();
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 7.0.wp,
              ),
              child: Row(
                children: [
                  Icon(
                    IconData(
                      task.icon,
                      fontFamily: 'MaterialIcons',
                    ),
                    color: color,
                    size: 17.0.sp,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 12.0.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () {
                var totalTodos =
                    homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 7.0.hp, vertical: 2.0.hp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 3.0.wp,
                        ),
                        child: Text(
                          "$totalTodos Tasks",
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeCtrl.doneTodos.length,
                          size: 5,
                          selectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color.withOpacity(0.5),
                              color,
                            ],
                          ),
                          unselectedGradientColor: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade300,
                              Colors.grey.shade300,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 2.0.wp,
                horizontal: 5.0.wp,
              ),
              child: Form(
                key: homeCtrl.formKey,
                child: TextFormField(
                  controller: homeCtrl.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey.shade400,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          var success =
                              homeCtrl.addTodo(homeCtrl.editController.text);
                          if (success) {
                            EasyLoading.showSuccess("Todo item add success");
                          } else {
                            EasyLoading.showError("Todo item already exist");
                          }
                          homeCtrl.tasks.refresh();
                          homeCtrl.editController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.done,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
            ),
            DoingList(
              task: task,
            ),
            // if (homeCtrl.doneTodos.isNotEmpty)
            //   Padding(
            //     padding:
            //         EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
            //     child: Container(
            //       height: 1,
            //       width: Get.width,
            //       decoration: BoxDecoration(
            //         color: Colors.grey.shade400,
            //       ),
            //     ),
            //   ),
            DoneList(task: task),
          ],
        ),
      ),
    );
  }
}
