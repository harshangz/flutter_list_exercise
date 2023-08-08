import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


enum DeviceType {phone,tablet}

class Utility{
  static const baseImgUrl = "http://duckduckgo.com";
  static String? buildFlavor = "simsons";
  static String appTitle = "The simsons character viewer";

  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone :DeviceType.tablet;
  }

  static loadProperty() async{
    buildFlavor = await MethodChannel("build_flavor").invokeMethod<String>("getFlavor");
    print("Flavor ==> $buildFlavor");
    if(buildFlavor == "wire") {
      appTitle = "The wire character viewer";
    } else {
      appTitle = "The simsons character viewer";
    }
  }
}