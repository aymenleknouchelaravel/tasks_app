import 'package:get/get.dart';
import 'package:todo/app/modules/home/controller.dart';

import '../../data/providers/task/provider.dart';
import '../../data/services/storage/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
