import 'package:asas/app/helpers/constance.dart';
import 'package:asas/app/theme/lightColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageSlider extends StatelessWidget {
  final List<String> images;
  const ImageSlider({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    late final PageController pageViewController = PageController(initialPage: 0);

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: 200.0,
          child: PageView(
            controller: pageViewController,
            physics: const BouncingScrollPhysics(),
            children: images.map(
                  (e) => ClipRRect(
                    borderRadius: BorderRadius.circular(7.0),
                    child: CachedNetworkImage(
                      imageUrl: Constance.imageProgramBaseUrl + e,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const Center(child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: LightColors.EDIT_BORDER_COLOR,
                          ),
                          child: Icon(
                            Icons.error,
                            color: LightColors.PRIMARY_COLOR,
                          )),
                      // width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
            ).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: SmoothPageIndicator(
            controller: pageViewController, // PageController
            count: images.length,
            effect: ExpandingDotsEffect(
                dotHeight: 8,
                dotWidth: 8,
                dotColor: Colors.grey.withOpacity(0.50),
                activeDotColor: LightColors.ACCENT_COLOR),
          ),
        ),
      ],
    );
  }
}
