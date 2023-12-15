import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingList extends StatelessWidget {
  final double? width;
  final double? height;
  final double margin;
  final int count;
  final Axis scrollDirection ;
  final bool circular;
  const LoadingList({Key? key, this.width, this.count = 4, this.height, this.scrollDirection = Axis.vertical, this.circular = false, this.margin = 10.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) => Shimmer.fromColors(
          highlightColor: Colors.grey.shade400,
          baseColor: Colors.grey.shade200,
          child: Container(
            width: width,
            height: circular ? width : height,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: margin),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(circular ? 100: 15), color: Colors.grey),
          )),
    );
  }
}
