import 'package:flutter/material.dart';

enum DeviceType {phone,tablet}

class Utility{
  static const baseImgUrl = "http://duckduckgo.com";
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromView(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? DeviceType.phone :DeviceType.tablet;
  }
}