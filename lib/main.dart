import 'package:flutter/material.dart';
import 'dart:math' as Math;

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: CardWidget(),
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  @override
  createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late Image cardFront;
  late Image cardBack;
  bool showFront = true;
  late AnimationController controller;
  late AnimationController animationController;
  var animation;
  var continuouslyYaxAnimation;

  @override
  void initState() {
    super.initState();

    // cardFront = Image.asset("assets/card-front.png");
    // cardBack  = Image.asset("assets/card-back.png");

    cardFront = Image.asset("images/Fern.jpg");
    cardBack = Image.asset("images/Fern-flip.jpg");

    // Initialize the animation controller
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
      value: 0,
    );

    animation = Tween<double>(begin: 0.0, end: Math.pi).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    // continuouslyYaxAnimation =
    //     Tween<double>(begin: 0.0, end: 2 * Math.pi).animate(
    //   CurvedAnimation(
    //     parent: CurvedAnimation(
    //       parent: controller..repeat(),
    //       curve: Curves.linear,
    //     ),
    //     curve: Curves.linear,
    //   ),
    // );

    controller.repeat(min: 0, max: 0.5, reverse: true);

    // controller.addListener(() {
    //   print(controller.value);
    //   if(controller.value == 0.5 || controller.value == 0){
    //     setState((){
    //       //showFront = !showFront;
    //       print(showFront);});
    //   }
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // precacheImage(cardFront.image, context);
    // precacheImage(cardBack.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
               AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.rotationY((controller.value) * Math.pi),
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height - 130,
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: cardFront,
                  ),
                );
              },
            ),
            // AnimatedBuilder(
            //   animation: animation,
            //   builder: (context, child) {
            //     return Transform(
            //       transform: Matrix4.rotationY(animation.value),
            //       child: cardFront,
            //     );
            //   },
            // ),
            // AnimatedBuilder(
            //   animation: animation,
            //   builder: (context, child) {
            //     return Transform.rotate(
            //       angle: continuouslyYaxAnimation.value,
            //       alignment: Alignment.center,
            //             child: Container(
            //         height: MediaQuery.of(context).size.height - 130,
            //         margin: EdgeInsets.only(top: 20),
            //         alignment: Alignment.center,
            //         child: showFront ? cardFront : cardBack,
            //       ),

            //     );
            //   },
            // ),

            ElevatedButton(
              child: const Text("flip"),
              onPressed: () async {
                // Flip the image
                await controller.forward();
                setState(() => showFront = !showFront);
                await controller.reverse();
              },
            ),
            ElevatedButton(
              child: const Text("spent"),
              onPressed: () async {
                // Flip the image
                controller.repeat();
              },
            ),
            ElevatedButton(
              child: const Text("stop"),
              onPressed: () async {
                // Flip the image
                controller.stop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
