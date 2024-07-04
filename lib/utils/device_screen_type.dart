import 'package:flutter/material.dart';

class DeviceScreenType {
  static bool isMobile(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width <= 800;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 800 && width <= 1200;
  }

  static bool isWeb(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width > 1200;
  }
}