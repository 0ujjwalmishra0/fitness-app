import 'package:fitness_app/components/listTile.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    Key key,
    this.iconSrc,
    this.title,
    this.press,
  }) : super(key: key);
  final String iconSrc, title;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: MyListTile( iconSrc: iconSrc, title: title,trailingIcon: 
              Icons.arrow_forward_ios,),
    );
  }
}
