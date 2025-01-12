import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

shimmerEventDetails(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.only(right: 0),
    child: SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        SizedBox(
          height: 300,
          child: Shimmer.fromColors(
            baseColor: Colors.pink.shade50,
            highlightColor: Colors.grey[100]!,
            direction: ShimmerDirection.ltr,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ]),
    ),
  );
}
