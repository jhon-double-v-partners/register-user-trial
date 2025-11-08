import 'package:double_v_partners/presentation/views/views.dart';
import 'package:flutter/material.dart';

class SlideInfo {
  final String title;
  final Widget content;

  const SlideInfo(this.title, this.content);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageViewController = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  void nextPage() {
    if (!isLastPage) {
      pageViewController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      if (isLastPage) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Por favor, completa el requisito antes de continuar',
            ),
          ),
        );
      }
    }
  }

  void previousPage() {
    if (!context.mounted) return;

    pageViewController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      final double page = pageViewController.page?.roundToDouble() ?? 0;

      setState(() {
        isLastPage = false;
      });

      if (!isLastPage && page >= 1.5) {
        setState(() {
          isLastPage = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    final slides = <SlideInfo>[
      SlideInfo(
        'Nuevo usuario',
        PersonalData(onNextPage: nextPage, currentPage: currentPage),
      ),
      SlideInfo(
        'Dirección',
        AddressView(
          onNextPage: nextPage,
          onPreviousPage: previousPage,
          currentPage: currentPage,
        ),
      ),
      SlideInfo('', DoneView()),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                    slides[currentPage].title,
                    style: TextStyle(
                      color: themeColors.secondary,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: PageView(
                    controller: pageViewController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) =>
                        setState(() => currentPage = index),
                    children: slides
                        .map((slideData) => slideData.content)
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.02,
              decoration: BoxDecoration(color: themeColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
