import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/snackBar_utils.dart';
import '../../../helpers/my_dialogs.dart';
import '../../../helpers/pref.dart';
import '../../../models/vpn.dart';
import '../../../models/vpn_config.dart';
import '../../../services/vpn_engine.dart';

class HomePageController extends GetxController {
  RxBool isActive = false.obs;

  final Rx<Vpn> vpn = Pref.vpn.obs;

  final vpnState = VpnEngine.vpnDisconnected.obs;

  void connectToVpn() async {
    // Net Connection Check Logic
    var conectivityResult = await (Connectivity().checkConnectivity());
    if (conectivityResult == ConnectivityResult.mobile ||
        conectivityResult == ConnectivityResult.wifi ||
        conectivityResult == ConnectivityResult.vpn) {
      // Vpn Click Logic
      if (vpn.value.openVPNConfigDataBase64.isEmpty) {
        MyDialogs.info(
            msg: 'Select a Location by clicking \'Select Location\'');
        return;
      }
      if (vpnState.value == VpnEngine.vpnDisconnected) {
        final data = Base64Decoder().convert(vpn.value.openVPNConfigDataBase64);
        final config = Utf8Decoder().convert(data);
        final vpnConfig = VpnConfig(
            country: vpn.value.countryLong,
            username: 'vpn',
            password: 'vpn',
            config: config);
        await VpnEngine.startVpn(vpnConfig);
      } else {
        await VpnEngine.stopVpn();
      }
    } else {
      print("No Internet Connected");
      showSnackMessage(
          title: "Error", message: "No Internet Connected", seconds: 1);
      return null;
    }
  }

  // vpn buttons color
  Color get getButtonColor {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return Colors.grey;

      case VpnEngine.vpnConnected:
        return Colors.tealAccent;

      default:
        return Colors.orangeAccent.withOpacity(.5);
    }
  }

  // vpn button text
  String get getButtonText {
    switch (vpnState.value) {
      case VpnEngine.vpnDisconnected:
        return 'Tap to Connect';

      case VpnEngine.vpnConnected:
        return 'Disconnect';

      default:
        return 'Connecting...';
    }
  }
}
