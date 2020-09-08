import 'package:flutter/material.dart';

class Background_VP extends StatelessWidget {
  final Widget child;
  const Background_VP({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      // Here i can use size.width but use double.infinity because both work as a same
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/bp9.png",
              width: size.width,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
