import 'package:flutter/material.dart';

class ShimmerArrowWidget extends StatefulWidget {
  const ShimmerArrowWidget({super.key});

  @override
  State<ShimmerArrowWidget> createState() => _ShimmerArrowWidgetState();
}

class _ShimmerArrowWidgetState extends State<ShimmerArrowWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

@override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController.unbounded(vsync: this)..repeat(min:  -0.5, max: 1.5, period: Duration(seconds: 1)); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:  _animationController, 
      builder: (_, child){ 
      return ShaderMask(
        shaderCallback: (bonds) => LinearGradient(
          begin: Alignment.centerRight, 
          end: Alignment.centerLeft,
          transform: _SlideGradientTransform(percent: _animationController.value),
          colors: const [
          Colors.white10,
          Colors.white, 
          Colors.white10
      
        ]).createShader(bonds),
        child: child
        );
      },
      child: const Row(
          children: [
            Align(heightFactor: 1, child: Icon(Icons.arrow_back_ios_sharp),),
            Align(heightFactor: 1, child: Icon(Icons.arrow_back_ios_sharp),),
            Align(heightFactor: 1, child: Icon(Icons.arrow_back_ios),),
          ],)
      ); 
  }
}

class _SlideGradientTransform extends GradientTransform{
  final double percent;

  const _SlideGradientTransform({required this.percent}); 
  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
  return Matrix4.translationValues(0, -bounds.height * percent, 0);
  }

}