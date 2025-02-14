import 'package:flutter/cupertino.dart';
import 'package:menus/utils/dimensions.dart';
import 'package:menus/widgets/small_text.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: Dimensions.iconSize24),
        SizedBox(
          width: Dimensions.width5,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: iconColor),
        ),
      ],
    );
  }
}
