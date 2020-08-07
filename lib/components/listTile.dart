import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({
    Key key,
    @required this.iconSrc,
    @required this.title,
    @required this.trailingIcon,
  }) : super(key: key);

  final String iconSrc;
  final String title;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: defaultSize * 3,
          right: defaultSize * 3,
          top: defaultSize*2.5,
          bottom: defaultSize*1 ),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            SvgPicture.asset(iconSrc),
            SizedBox(width: defaultSize * 2),
            Text(
              title,
              style: TextStyle(
                fontSize: defaultSize * 1.6, //16
                color: kTextLigntColor,
              ),
            ),
            Spacer(flex: 1,),
            Icon(
              // Icons.arrow_forward_ios,
              trailingIcon,
              size: defaultSize * 1.6,
              color: kTextLigntColor,
            ),
            SizedBox(width: size.width*0.03,)
          ],
        ),
      ),
    );
  }
}
