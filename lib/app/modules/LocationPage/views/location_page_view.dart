import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../HomePage/controllers/HomePage_controller.dart';
import '../../../helpers/pref.dart';
import '../../../services/vpn_engine.dart';
import '../controllers/location_page_controller.dart';

class LocationPageView extends GetView<LocationPageController> {
  const LocationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // late final controller = Get.put(LocationPageController());
    final controller = Get.put(LocationPageController());
    final controller2 = Get.find<HomePageController>();
    if (controller.vpnList.isEmpty) controller.getVpnData();
    return Obx(
      () => Scaffold(
        backgroundColor: Color.fromARGB(255, 23, 22, 22),
        appBar: AppBar(
          foregroundColor: Colors.grey[400],
          backgroundColor: Colors.black,
          title: Text(
            'Choose Locations (${controller.vpnList.length})',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: controller.isLoading.value
            ? Center(
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.grey[400],
                    )),
              )
            : controller.vpnList.isEmpty
                ? Center(
                    child: Text(
                      'Servers Not Found! 😔',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : Column(
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.all(3),
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     height: 60,
                      //     width: double.infinity,
                      //     decoration: const BoxDecoration(
                      //         borderRadius: BorderRadius.only(
                      //             topLeft: Radius.circular(38),
                      //             topRight: Radius.circular(38)),
                      //         color: Colors.black),
                      //     child: const Text(
                      //       "Choose Locations(69)",
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: controller.vpnList.length,
                          itemBuilder: (context, index) {
                            var data = controller.vpnList[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Material(
                                elevation: 20,
                                borderRadius: BorderRadius.circular(20),
                                child: Semantics(
                                  button: true,
                                  child: InkWell(
                                    onTap: () {
                                      controller2.vpn.value =
                                          controller.vpnList[index];
                                      Pref.vpn = controller.vpnList[index];
                                      Get.back();
                                      if (controller2.vpnState.value ==
                                          VpnEngine.vpnConnected) {
                                        VpnEngine.stopVpn();
                                        Future.delayed(Duration(seconds: 2),
                                            () => controller2.connectToVpn());
                                      } else {
                                        controller2.connectToVpn();
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Container(
                                              height: 32,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // color: Colors.amber,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/flags/${data.countryShort.toLowerCase()}.png"))),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data.countryLong,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey[400]),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.speed,
                                                      color: Colors.grey[400],
                                                      size: 15,
                                                    ),
                                                    const SizedBox(width: 2),
                                                    Text(
                                                      _formatBytes(
                                                          data.speed, 1),
                                                      // "46.8 Mbps",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Colors.grey[400]),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Row(
                                              children: [
                                                Text(
                                                  "${data.numVpnSessions}",
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                                const SizedBox(width: 3),
                                                Icon(
                                                  Icons.people,
                                                  color: Colors.grey[400],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  String _formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ['Bps', "Kbps", "Mbps", "Gbps", "Tbps"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
