import 'package:flutter/material.dart';
import 'reusable.dart';

class MyAnimator extends StatefulWidget{
  _AnimatorState createState() => _AnimatorState();
}
class _AnimatorState extends State<MyAnimator> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller,curve: Curves.linearToEaseOut);

    animation = Tween(begin: 40.0, end: 100.0).animate(controller)

      ..addListener(() {
        setState(() {});
      });
    TickerFuture tickerFuture = controller.repeat(reverse: true);
    tickerFuture.timeout(Duration(seconds: 1 * 4), onTimeout: () {
      controller.forward(from: 40.0);
      controller.stop(canceled: true);
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            child: Baseline(
                baseline: animation.value,
                baselineType: TextBaseline.ideographic,
                child: Image.asset("assets/images/pencil.png")
            )
        ));
  }
}

class MyAnimator1 extends StatefulWidget{
  _Animator1State createState() => _Animator1State();

}
class _Animator1State extends State<MyAnimator1> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);

    TickerFuture tickerFuture = controller.repeat(reverse: true);
    tickerFuture.timeout(Duration(seconds: 1 * 4), onTimeout: () {
      controller.forward(from: 0);
     controller.stop(canceled: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
        child: Container(
            child: FadeTransition(
                opacity:  animation,
                child: CustomPaint(
                  size: Size(size.width / 2, size.height / 11.5),
                  painter: LinePainter(),
                )
            )));
  }
}