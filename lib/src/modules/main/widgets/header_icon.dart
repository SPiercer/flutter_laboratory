import 'package:flutter/material.dart';

class HeaderIcon extends StatelessWidget {
  final String os;
  const HeaderIcon(
    this.os, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    switch (os) {
      case 'android':
        icon = Icons.phone_android;
        break;
      case 'ios':
        icon = Icons.phone_iphone;
        break;
      case 'macos':
        icon = Icons.laptop_mac;
        break;
      case 'linux':
        icon = Icons.laptop;
        break;
      case 'windows':
        icon = Icons.desktop_windows;
        break;
      default:
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Icon(icon, size: 48),
    );
  }
}
