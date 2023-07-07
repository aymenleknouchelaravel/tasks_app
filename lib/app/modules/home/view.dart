import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/app/modules/home/widgets/add_card.dart';
import 'package:todo/app/modules/home/widgets/add_dialog.dart';
import 'package:todo/app/modules/home/widgets/task_card.dart';
import '../../data/models/task.dart';
import '../report/view.dart';
import 'controller.dart';
import '../../../app/core/util/extensions.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(right: 0.0.sp),
                  child: const Icon(Icons.apps),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(left: 0.0.sp),
                  child: const Icon(Icons.data_usage),
                ),
                label: 'Report',
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: DragTarget(
          onAccept: (Task task) {
            controller.tasks.remove(task);
            EasyLoading.showSuccess('Task deleted');
          },
          builder: (_, __, ___) {
            return Obx(
              () => FloatingActionButton(
                backgroundColor: controller.deleting.value ? Colors.red : null,
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(
                      AddDialog(),
                      transition: Transition.downToUp,
                    );
                  } else {
                    EasyLoading.showInfo('Please Create a Task Type');
                  }
                },
                child: Icon(
                  controller.deleting.value ? Icons.delete : Icons.add,
                  color:
                      controller.deleting.value ? Colors.white : Colors.white,
                ),
              ),
            );
          },
        ),
        body: IndexedStack(
          index: controller.tabIndex.value,
          children: [
            SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      'My List',
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        AddCard(),
                        ...controller.tasks
                            .map(
                              (e) => LongPressDraggable(
                                data: e,
                                onDragStarted: () {
                                  controller.changeDeleting(true);
                                },
                                onDraggableCanceled: (_, __) {
                                  controller.changeDeleting(false);
                                },
                                onDragCompleted: () {
                                  controller.changeDeleting(false);
                                },
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(
                                    task: e,
                                  ),
                                ),
                                child: TaskCard(
                                  task: e,
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ReportPage(),
          ],
        ),
      );
    });
  }
}
