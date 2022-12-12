import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:project_integration_pb/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class AddPostScreen extends ConsumerWidget {
  const AddPostScreen({super.key});

  void navigateToType(BuildContext context, String type){
    Routemaster.of(context).push('/add-post/$type');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cardHeightWidth = 150;
    double iconSize = 60;
    final currentTheme = ref.watch(themeNotifierProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => navigateToType(context, 'image'),
          child: SizedBox(
            height: cardHeightWidth,
            width: 900,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.backgroundColor,
              elevation: 16,
              child: Center(
                child: Lottie.network(
                  "https://assets2.lottiefiles.com/packages/lf20_dggAm75MbY.json",
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () => navigateToType(context, 'text'),
          child: SizedBox(
            height: cardHeightWidth,
            width: 900,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.backgroundColor,
              elevation: 16,
              child: Center(
                child: Lottie.network(
                  "https://assets3.lottiefiles.com/private_files/lf30_cldvedro.json",
                ),
              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () => navigateToType(context, 'link'),
          child: SizedBox(
            height: cardHeightWidth,
            width: 900,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.backgroundColor,
              elevation: 16,
              child: Center(
                child: Lottie.network(
                    "https://assets7.lottiefiles.com/packages/lf20_7tbuvbtj.json",
                  ),

              ),
            ),
          ),
        ),

        GestureDetector(
          onTap: () => navigateToType(context, 'demand'),
          child: SizedBox(
            height: cardHeightWidth,
            width: 900,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: currentTheme.backgroundColor,
              elevation: 16,
              child: Center(
                child: Lottie.network(
                  "https://assets4.lottiefiles.com/packages/lf20_FtWlyLkTHI.json",
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
