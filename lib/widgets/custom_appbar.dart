import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/values/color_scheme.dart';

import '../values/styles.dart'; // Import services for SystemChrome

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final IconData leadingIcon;
  final VoidCallback? leadingCallback;

  const CustomAppBar({
    super.key,
    this.backgroundColor = CustomColorScheme.primary,
    this.leadingIcon = Icons.arrow_back_ios_new_rounded,
    this.leadingCallback, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness:
          ThemeData.estimateBrightnessForColor(backgroundColor),
    ));

    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: Styles.customTextStylePopins(
          fontSize: 25,
          color: CustomColorScheme.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      
      centerTitle: true,
      leading: leadingCallback != null
          ? IconButton(
              onPressed: leadingCallback,
              icon: Icon(
                leadingIcon,
                color: Colors.white,
              ),
            )
          : null,
      toolbarHeight: 70,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
