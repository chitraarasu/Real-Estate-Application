import 'package:flutter/material.dart';
import 'package:real_estate/utils/manager/color_manager.dart';

class CDrawer extends StatelessWidget {
  const CDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: darkBlue,
      body: Text('Sidebar'),
    );
  }
}
