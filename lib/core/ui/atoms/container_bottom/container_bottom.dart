import 'package:flutter/material.dart';

class ContainerBottom extends StatelessWidget {
  const ContainerBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.02,
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
