import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/util/extensions.dart';
import '../../../data/models/task.dart';
import '../../home/controller.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final Task task;
  DoneList({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);

    return Obx(
      () => ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...homeCtrl.doneTodos
              .map(
                (element) => Dismissible(
                     key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          homeCtrl.removeDoneTodo(
                            element["title"],
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: const Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 3.0.wp,
                      horizontal: 8.0.wp,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.done,
                          color: color,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                          child: Text(
                            "${element["title"]}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
