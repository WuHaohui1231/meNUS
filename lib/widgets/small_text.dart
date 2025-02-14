import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  TextOverflow overflow;
  double size;
  double height;
  SmallText(
      {Key? key,
      this.color = AppColors.paraColor,
      required this.text,
      this.size = 12,
      this.height = 1.2,
      this.overflow = TextOverflow.clip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        height: height,
        fontFamily: 'Roboto',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        overflow: overflow,
      ),
    );
  }
}
