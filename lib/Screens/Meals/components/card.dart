import 'package:fitness_app/constants.dart';
import 'package:fitness_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardWidget extends StatelessWidget {
  // final Card recipeBundle;
  final Function press;
  final String title;
  final String imgSrc;

  const CardWidget({
    Key key, 
    this.imgSrc,
    this.title,
  // this.recipeBundle,
   this.press})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // Now we dont this Aspect ratio
    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
        ),
        child: Row( 
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2), //20
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: defaultSize * 2.2, //22
                          color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: defaultSize * 0.5), // 5
                    // Text(
                    //   recipeBundle.description,
                    //   style: TextStyle(color: Colors.white54),
                    //   maxLines: 2,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    // Spacer(),
                    // buildInfoRow(
                    //   defaultSize,
                    //   iconSrc: "assets/icons/pot.svg",
                    //   text: "${recipeBundle.recipes} Recipes",
                    // ),
                    // SizedBox(height: defaultSize * 0.5), //5
                    // buildInfoRow(
                    //   defaultSize,
                    //   iconSrc: "assets/icons/chef.svg",
                    //   text: "${recipeBundle.chefs} Chefs",
                    // ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(width: defaultSize * 0.5), //5
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.asset(
                imgSrc,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//   Row buildInfoRow(double defaultSize, {String iconSrc, text}) {
//     return Row(
//       children: <Widget>[
//         SvgPicture.asset(iconSrc),
//         SizedBox(width: defaultSize), // 10
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         )
//       ],
//     );
//   }
// }