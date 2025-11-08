import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  const SlideInfo(this.title, this.caption, this.imageUrl);
}

final slides = <SlideInfo>[
  SlideInfo(
    'Search for a food',
    'Dolor ut qui fugiat deserunt esse proident.',
    'assets/images/1.png',
  ),
  SlideInfo(
    'Fast food',
    'Est nisi nulla anim laboris aliquip adipisicing.',
    'assets/images/2.png',
  ),
  SlideInfo(
    'Search for a food',
    'Aliquip mollit esse laborum consequat labore elit dolor mollit.',
    'assets/images/3.png',
  ),
];

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

      if (!isLastPage && page >= slides.length - 1.5) {
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
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageViewController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => currentPage = index),
            children: slides
                .map(
                  (slideData) => _Slide(
                    title: slideData.title,
                    caption: slideData.caption,
                    imageUrl: slideData.imageUrl,
                  ),
                )
                .toList(),
          ),

          _LastPageControls(
            nextPage: nextPage,
            previousPage: previousPage,
            currentPage: currentPage,
          ),
        ],
      ),
    );
  }
}

class _LastPageControls extends StatelessWidget {
  final Function nextPage;
  final Function previousPage;
  final int currentPage;

  const _LastPageControls({
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
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

class _Slide extends StatelessWidget {
  const _Slide({
    required this.title,
    required this.caption,
    required this.imageUrl,
  });

  final String title;
  final String caption;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(image: AssetImage(imageUrl)),
            ),

            const SizedBox(height: 24.0),

            Text(title, style: titleStyle),

            const SizedBox(height: 8.0),

            Text(caption, style: captionStyle),
          ],
        ),
      ),
    );
  }
}
