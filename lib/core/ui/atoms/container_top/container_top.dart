import 'package:flutter/material.dart';

class ContainerTop extends StatelessWidget {
  final String title;
  const ContainerTop({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      decoration: BoxDecoration(color: themeColors.primary),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: themeColors.primaryFixed,
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
