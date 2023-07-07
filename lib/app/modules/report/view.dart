import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/app/core/util/extensions.dart';
import '../home/controller.dart';

class ReportPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalTodos = homeCtrl.getTotalTasks();
    int getDoneTasks = homeCtrl.getDoneTasks();
    int getDoingTasks = totalTodos - getDoneTasks;
    double pourcentage = (getDoneTasks / totalTodos) * 100;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'Report',
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
            child: Text(
              DateFormat('dd MMMM yyyy').format(
                DateTime.now(),
              ),
              style: TextStyle(
                fontSize: 15.0.sp,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          SizedBox(
            height: 8.0.wp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.0.wp,
              vertical: 3.0.wp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatus(getDoingTasks, 'Created', Colors.yellow.shade600),
                _buildStatus(getDoneTasks, 'Completed', Colors.green),
                _buildStatus(totalTodos, 'All Tasks', Colors.blue),
              ],
            ),
          ),
          SizedBox(
            height: 8.0.wp,
          ),
          UnconstrainedBox(
            child: SizedBox(
              width: 70.0.wp,
              height: 70.0.wp,
              child: CircularStepProgressIndicator(
                totalSteps: totalTodos == 0 ? 1 : totalTodos,
                currentStep: getDoneTasks,
                stepSize: 20,
                selectedColor: Colors.green.shade700,
                unselectedColor: Colors.grey.shade300,
                padding: 0,
                width: 150,
                height: 150,
                selectedStepSize: 22,
                roundedCap: (_, __) => true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      pourcentage > 0
                          ? "${pourcentage.toStringAsFixed(0)}%"
                          : "0%",
                      style: TextStyle(
                        fontSize: 20.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Row _buildStatus(int number, String title, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 3.0.wp,
        width: 3.0.wp,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 2.0.sp,
            color: color,
          ),
        ),
      ),
      SizedBox(width: 2.0.wp),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$number',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 0.5.hp,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 11.0.sp,
            ),
          ),
        ],
      )
    ],
  );
}
