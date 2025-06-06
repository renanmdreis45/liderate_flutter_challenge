import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
