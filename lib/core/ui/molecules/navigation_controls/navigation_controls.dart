import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class NavigationControls extends StatelessWidget {
  final Function nextPage;
  final Function previousPage;
  final int currentPage;

  const NavigationControls({
    super.key,
    required this.nextPage,
    required this.previousPage,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              currentPage > 0
                  ? FadeInRight(
                      from: 14,
                      delay: const Duration(milliseconds: 100),
                      child: FloatingActionButton(
                        onPressed: currentPage == 0
                            ? null
                            : () => previousPage(),
                        child: const Icon(Icons.arrow_back_ios_sharp),
                      ),
                    )
                  : const SizedBox(),

              FadeInLeft(
                from: 14,
                delay: const Duration(milliseconds: 100),
                child: FloatingActionButton(
                  onPressed: () => nextPage(),
                  child: const Icon(Icons.arrow_forward_ios_sharp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
