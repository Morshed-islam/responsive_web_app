import 'package:flutter/material.dart';

import '../screens/mobile_layout.dart';
import '../screens/tablet_layout.dart';
import '../screens/web_layout.dart';

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Layout'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return WebLayout();
          } else if (constraints.maxWidth > 800 && constraints.maxWidth <= 1200) {
            return TabletLayout();
          } else {
            return MobileLayout();
          }
        },
      ),
    );
  }
}
