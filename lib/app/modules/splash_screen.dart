import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:vpn_basic_project/app/modules/LocationPage/controllers/location_page_controller.dart';
import 'HomePage/views/HomePage_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var controller = Get.put(LocationPageController());
    controller.getVpnData();
    Future.delayed(Duration(milliseconds: 1500), () {
      Get.off(() => HomePageView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 130,
              ),
              SizedBox(height: 10),
              SizedBox(
                  height: 25,
                  width: 25,
                  child: FittedBox(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ));
  }
}
