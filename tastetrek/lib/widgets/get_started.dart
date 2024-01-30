import 'package:flutter/material.dart';
import 'dart:math' as math;import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';


class GetstartedWidget extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
          // Figma Flutter Generator GetstartedWidget - FRAME
            return Container(
      width: 414,
      height: 736,
      decoration: const BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
      color : Color.fromRGBO(247, 247, 247, 1),
  ),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 321,
        left: 54,
        child: Container(
      width: 298,
      height: 309,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 266,
        left: 34,
        child: Container(
      width: 238,
      height: 43,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Container(
        width: 238,
        height: 43,
        decoration: const BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
      color : Color.fromRGBO(254, 189, 46, 1),
  )
      )
      ),const Positioned(
        top: 9,
        left: 70.63225555419922,
        child: Text('Get Started', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Montserrat',
        fontSize: 20,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 9,
        left: 18.425804138183594,
        child: Container(
      width: 25.574195861816406,
      height: 25,
      
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: SvgPicture.asset(
        'assets/images/vector.svg',
        semanticsLabel: 'vector'
      )
      ),Positioned(
        top: 7.5,
        left: 12.78709888458252,
        child: SvgPicture.asset(
        'assets/images/vector.svg',
        semanticsLabel: 'vector'
      )
      ),Positioned(
        top: 12.5,
        left: 7.6722612380981445,
        child: SvgPicture.asset(
        'assets/images/vector.svg',
        semanticsLabel: 'vector'
      )
      ),
        ]
      )
    )
      ),
        ]
      )
    )
      ),Positioned(
        top: 0,
        left: 34,
        child: Transform.rotate(
        angle: 1.5902773407317584e-15 * (math.pi / 180),
        child: const Text('Tastetrek', textAlign: TextAlign.left, style: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat Alternates',
        fontSize: 48,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),),
      )
      ),Positioned(
        top: 73,
        left: 0,
        child: Transform.rotate(
        angle: 1.5902773407317584e-15 * (math.pi / 180),
        child: const Text('All that you need for a perfect meal plan in one place!', textAlign: TextAlign.center, style: TextStyle(
        color: Color.fromRGBO(196, 188, 165, 1),
        fontFamily: 'Montserrat Alternates',
        fontSize: 16,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),),
      )
      ),
        ]
      )
    )
      ),
        ]
      )
    );
          }
        }