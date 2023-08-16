// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ViewImagePage extends StatefulWidget {
  ViewImagePage({Key? key, required this.title, required this.urlImage}) : super(key: key);
  String title;
  String urlImage;

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> with SingleTickerProviderStateMixin{
  late TransformationController controller;
  TapDownDetails? tapDownDetails;

  late AnimationController animationController;
  Animation<Matrix4>? animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TransformationController();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300))..addListener(() {
      controller.value = animation!.value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    controller.dispose();
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onDoubleTapDown: (details) => tapDownDetails = details,
          onDoubleTap: () {
            final position = tapDownDetails!.localPosition;
            const double scale = 3;
            final x = -position.dx * (scale-1);
            final y = -position.dy * (scale-1);
            final zoomed = Matrix4.identity()
              ..translate(x, y)
              ..scale(scale);

            final value = controller.value.isIdentity() ? zoomed : Matrix4.identity();

            animation = Matrix4Tween(
              begin: controller.value,
              end: value
            ).animate(
              CurveTween(curve: Curves.easeOut).animate(animationController)
            );

            animationController.forward(from: 0);

          },
          child: InteractiveViewer(
            clipBehavior: Clip.none,
            transformationController: controller,
            child: Image.network(widget.urlImage)
          ),
        ),
      ),
    );
  }
}
