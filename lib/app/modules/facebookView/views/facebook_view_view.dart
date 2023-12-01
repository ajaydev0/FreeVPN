import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/facebook_view_controller.dart';

class FacebookViewView extends GetView<FacebookViewController> {
  const FacebookViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FacebookViewController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Owner Facebook Account'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Obx(
            () => controller.webLoading.value < 1
                ? LinearProgressIndicator(
                    value: controller.webLoading.value,
                  )
                : Container(),
          ),
          Expanded(
              child: WebViewWidget(
            controller: controller.controller,
          )),
        ],
      ),
    );
  }
}
