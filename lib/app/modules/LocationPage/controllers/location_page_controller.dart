import 'package:get/get.dart';
import '../../../apis/apis.dart';
import '../../../helpers/pref.dart';
import '../../../models/vpn.dart';

class LocationPageController extends GetxController {
  // @override
  // void onInit() {
  //   super.onInit();
  //   getVpnData();
  // }

  List<Vpn> vpnList = Pref.vpnList;

  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    vpnList.clear();
    vpnList = await APIs.getVPNServers();
    isLoading.value = false;
  }
}
