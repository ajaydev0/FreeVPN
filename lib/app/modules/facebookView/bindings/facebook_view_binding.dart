import 'package:get/get.dart';

import '../controllers/facebook_view_controller.dart';

class FacebookViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FacebookViewController>(
      () => FacebookViewController(),
    );
  }
}
