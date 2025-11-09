import 'package:flutter/foundation.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
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

  void onFinish() {
    pageViewController.jumpToPage(0);
  }

  @override
  void dispose() {
    pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      SlideInfo('', DoneView(onFinish: onFinish)),
    ];

    return Scaffold(
      body: Column(
        children: [
          !isLastPage
              ? ContainerTop(title: slides[currentPage].title)
              : Container(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: PageView(
                controller: pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => currentPage = index),
                children: slides.map((slideData) {
                  return Center(
                    child: FractionallySizedBox(
                      widthFactor: kIsWeb ? 0.4 : 1.0,
                      child: slideData.content,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          ContainerBottom(),
        ],
      ),
    );
  }
}
