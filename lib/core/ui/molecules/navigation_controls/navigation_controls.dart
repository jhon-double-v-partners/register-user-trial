import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        currentPage > 0
            ? FadeInRight(
                from: 14,
                delay: const Duration(milliseconds: 100),
                child: CustomButton(
                  onPressed: currentPage == 0 ? null : () => previousPage(),
                  icon: const Icon(Icons.arrow_back_ios_sharp),
                  text: 'Volver',
                ),
              )
            : const SizedBox(),

        FadeInLeft(
          from: 14,
          delay: const Duration(milliseconds: 100),
          child: CustomButton(
            onPressed: () => nextPage(),
            icon: const Icon(Icons.arrow_forward_ios_sharp),
            text: 'Continuar',
          ),
        ),
      ],
    );
  }
}
