import 'package:bear/consts/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback fuc;
  final double scaleUp;

  const CustomButton({
    Key? key,
    required this.text,
    required this.fuc,
    this.scaleUp = 1.2,
  }) : super(key: key);

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 1.0,
        end: widget.scaleUp,
      ).animate(_controller),
      child: ElevatedButton(
        onPressed: _onButtonTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return AppColor.secondaryColor;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return AppColor.mainColor;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(16),
          ),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(fontFamily: "SingleDay", fontSize: 25),
        ),
      ),
    );
  }

  void _onButtonTap() {
    _controller.forward();
    widget.fuc();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
