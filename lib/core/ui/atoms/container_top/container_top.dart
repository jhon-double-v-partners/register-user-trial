import 'package:flutter/material.dart';

class ContainerTop extends StatelessWidget {
  final String title;

  const ContainerTop({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    return ClipPath(
      clipper: BottomCurveClipper(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.16,
        width: double.infinity,
        decoration: BoxDecoration(color: themeColors.primary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: themeColors.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, size.height - 42);

    final firstControlPoint = Offset(size.width / 2, size.height);
    final firstEndPoint = Offset(size.width, size.height - 42);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
