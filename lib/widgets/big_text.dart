import 'package:flutter/cupertino.dart';
import 'package:menus/utils/colors.dart';
import '../utils/dimensions.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  FontWeight weight;
  TextOverflow overFlow;
  BigText(
      {Key? key,
      this.color = AppColors.mainBlackColor,
      required this.text,
      this.size = 17,
      this.weight = FontWeight.normal,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size == 0 ? Dimensions.font20 : size,
          fontWeight: weight),
    );
  }
}
