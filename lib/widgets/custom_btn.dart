import 'package:flutter/material.dart';
import 'package:music_app/values/styles.dart';
import '../../values/color_scheme.dart';

class CustomBtn extends StatefulWidget {
  const CustomBtn({
    super.key,
    required this.ontap,
    this.title,
    this.color,
    this.height = 50,
    this.width = 300,
    this.borderColor = false,
    this.textColor = Colors.white,
    this.horizontalPadding=20,
  });
  final VoidCallback? ontap;
  final String? title;
  final Color? color, textColor;
  final double? height;
  final double? width;
  final bool? borderColor;
  final double? horizontalPadding;

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: widget.horizontalPadding!),
      height: widget.height,
      width: widget.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: widget.color,
            side: BorderSide(
                color: widget.borderColor == true
                    ? CustomColorScheme.primary
                    : Colors.transparent),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          onPressed: widget.ontap,
          child: FittedBox(
              child: Text(widget.title ?? "click",
                  style: Styles.customTextStylePopins(fontSize: 18,color:widget.textColor!,fontWeight: FontWeight.w500 )))),
    );
  }
}



// class SubmitIconBtn extends StatelessWidget {
//   SubmitIconBtn(
//       {Key? key,
//       this.textColor,
//       this.title,
//       this.bgColor,
//       this.icon,
//       this.ontap})
//       : super(key: key);
//   String? title;
//   Color? textColor;
//   String? icon;
//   VoidCallback? ontap;
//   Color? bgColor;
//   @override
//   Widget build(BuildContext context) {
//     return SweetButton(
//       onPressed: ontap ?? () {},
//       child: Chip(
//         elevation: 2,
//         backgroundColor: bgColor ?? CustomColorScheme.primary,
//         shadowColor: Colors.grey,
//         side: BorderSide.none,
//         // surfaceTintColor: CustomColorScheme.iconColor,
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         shape: const StadiumBorder(),
//         label: Text(
//           title ?? "",
//           style: regularWhiteText14(textColor ?? Colors.black),
//           textAlign: TextAlign.center,
//         ),
//         avatar: isNotEmpty(icon)
//             ? Image.asset(
//                 icon!,
//                 height: 20,
//                 width: 20,
//               )
//             : null,
//       ),
//     );
//   }
// }
