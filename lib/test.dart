import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';

import 'controller/test_controller.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(
        backgroundColor: AppColor.whiteColor,
        body: GetBuilder<TestController>(builder: ((controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.isCallIncoming),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    // controller.playMusic();
                  },
                  color: Colors.grey,
                  child: const Text("Play"),
                ),
              ),
            ],
          );
        })));
  }
}
