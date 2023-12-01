import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/app/modules/facebookView/views/facebook_view_view.dart';
import '../../../apis/apis.dart';
import '../../../models/ip_details.dart';
import '../../../models/network_data.dart';
import '../../../models/vpn_status.dart';
import '../../LocationPage/views/location_page_view.dart';
import '../../../services/vpn_engine.dart';
import '../../../widgets/count_down_timer.dart';
import '../controllers/HomePage_controller.dart';
import '../widgets/Drawer_card_Item.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //Scaffold Key
    final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
    // Get Drawer Data
    final dataIp = IPDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: dataIp);
    // Controller
    final controller = Get.put(HomePageController());

    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      controller.vpnState.value = event;
    });

    return SafeArea(
      child: Obx(
        () => Scaffold(
            key: globalKey,
            backgroundColor: Colors.black,
            drawer: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Drawer(
                backgroundColor: Color.fromARGB(255, 23, 22, 22),
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(FacebookViewView());
                            },
                            child: Container(
                              height: 172,
                              child: Stack(
                                children: [
                                  Material(
                                    elevation: 10,
                                    color: Colors.black,
                                    shape: CircleBorder(),
                                    child: Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 5),
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                          image: DecorationImage(
                                              fit: BoxFit.fitHeight,
                                              image: AssetImage(
                                                  "assets/admin.JPG"))),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    right: 85,
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: Colors.blue[800],
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.facebook,
                                        color: Colors.grey[200],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Ajay Dev",
                          style: GoogleFonts.laila(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Owner Of This App.",
                          style: GoogleFonts.laila(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      ]),
                      Column(children: [
                        //ip
                        NetworkCard(
                            data: NetworkData(
                                title: 'IP Address',
                                subtitle: dataIp.value.query,
                                icon: Icon(CupertinoIcons.location_solid,
                                    color: Colors.blue))),

                        //isp
                        NetworkCard(
                            data: NetworkData(
                                title: 'Internet Provider',
                                subtitle: dataIp.value.isp,
                                icon: Icon(Icons.business,
                                    color: Colors.orange))),

                        // location
                        NetworkCard(
                            data: NetworkData(
                                title: 'Location',
                                subtitle: dataIp.value.country.isEmpty
                                    ? 'Searching...'
                                    : '${dataIp.value.city}, ${dataIp.value.regionName}, ${dataIp.value.country}',
                                icon: Icon(CupertinoIcons.location,
                                    color: Colors.pink))),

                        //pin code
                        NetworkCard(
                            data: NetworkData(
                                title: 'Pin-code',
                                subtitle: dataIp.value.zip,
                                icon: Icon(CupertinoIcons.location_solid,
                                    color: Colors.cyan))),

                        //timezone
                        NetworkCard(
                            data: NetworkData(
                                title: 'Timezone',
                                subtitle: dataIp.value.timezone,
                                icon: Icon(CupertinoIcons.time,
                                    color: Colors.green))),
                        SizedBox(height: 20),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    dataIp.value = IPDetails.fromJson({});
                    APIs.getIPDetails(ipData: dataIp);
                    globalKey.currentState?.openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white70,
                  )),
              backgroundColor: Colors.black87,
              title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Free",
                      style: TextStyle(color: Colors.tealAccent, fontSize: 20),
                    ),
                    Text(
                      "VPN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ]),
              centerTitle: true,
              actions: [
                Semantics(
                  button: true,
                  child: InkWell(
                    onTap: () {
                      // istheme.changeTheme();
                    },
                    customBorder: const CircleBorder(),
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                          border:
                              Border.all(color: Colors.white.withOpacity(.2)),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.dark_mode,
                          color: Colors.white70,
                        )),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      "It's Totaly Free",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white54),
                    ),
                    const SizedBox(height: 5),
                    // Text(
                    //   "Enjoy",
                    //   style: TextStyle(color: Colors.white38),
                    // ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => LocationPageView());
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            border:
                                Border.all(color: Colors.white.withOpacity(.2)),
                          ),
                          child: Row(
                            children: [
                              controller.vpn.value.countryLong.isEmpty
                                  ? Icon(Icons.vpn_lock_rounded,
                                      size: 30, color: Colors.tealAccent)
                                  : Container(
                                      height: 30,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/flags/${controller.vpn.value.countryShort.toLowerCase()}.png'))),
                                    ),
                              const SizedBox(width: 10),
                              Text(
                                controller.vpn.value.countryLong.isEmpty
                                    ? 'Select Location....'
                                    : controller.vpn.value.countryLong,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[400]),
                              ),
                              const Spacer(),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.white70,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Obx(
                      () => Semantics(
                        button: true,
                        child: InkWell(
                          onTap: () {
                            controller.connectToVpn();
                            controller.isActive.value
                                ? controller.isActive.value = false
                                : controller.isActive.value = true;
                          },
                          customBorder: const CircleBorder(),
                          child: Material(
                            elevation: 20,
                            shape: const CircleBorder(),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.isActive.value
                                        ? controller.getButtonColor
                                            .withOpacity(.1)
                                        : Colors.grey.withOpacity(.1)),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: controller.getButtonColor,
                                    ),
                                    child: Container(
                                      height: 160,
                                      width: 160,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black),
                                      child: Icon(
                                        Icons.power_settings_new_rounded,
                                        size: 60,
                                        color: controller.getButtonColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        controller.vpnState.value == "disconnected"
                            ? SizedBox()
                            : controller.vpnState.value == "connected"
                                ? Icon(
                                    Icons.favorite_border,
                                    color: controller.getButtonColor,
                                    size: 25,
                                  )
                                : CupertinoActivityIndicator(
                                    color: controller.getButtonColor,
                                  ),
                        const SizedBox(width: 5),
                        Text(
                          controller.vpnState.value == VpnEngine.vpnDisconnected
                              ? 'Not Connected'
                              : controller.vpnState
                                  .replaceAll('_', ' ')
                                  .toUpperCase(),
                          style: TextStyle(
                              color: controller.getButtonColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    CountDownTimer(
                        startTimer: controller.vpnState.value == "connected"),
                    const SizedBox(height: 40),
                    StreamBuilder<VpnStatus?>(
                        initialData: VpnStatus(),
                        stream: VpnEngine.vpnStatusSnapshot(),
                        builder: (context, snapshot) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    const Text(
                                      "Download",
                                      style: TextStyle(
                                          color: Colors.tealAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    snapshot.data?.byteIn == null
                                        ? Text(
                                            '00.0',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Container(
                                            height: 30,
                                            width: 110,
                                            child: Text(
                                              snapshot.data?.byteIn ?? "00",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                    Text(
                                      "mbps",
                                      style: TextStyle(color: Colors.white24),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 50,
                                  width: 4,
                                  decoration: BoxDecoration(
                                      color: Colors.white24,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Upload",
                                      style: TextStyle(
                                          color: Colors.tealAccent,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    snapshot.data?.byteIn == null
                                        ? Text(
                                            '00.0',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70),
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Container(
                                            height: 30,
                                            width: 100,
                                            child: Text(
                                              snapshot.data?.byteOut ?? '00.0',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white70),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                    Text(
                                      "mbps",
                                      style: TextStyle(color: Colors.white24),
                                    ),
                                  ],
                                ),
                              ],
                            ))
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
