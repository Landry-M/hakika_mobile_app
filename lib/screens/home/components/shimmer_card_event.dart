import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

shimmerCardEvent(
  BuildContext context,
) {
  return Padding(
    padding: const EdgeInsets.only(right: 10),
    child: SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width / 1.7,
      child: Column(children: [
        SizedBox(
          height: 300,
          child: Shimmer.fromColors(
            baseColor: Colors.pink.shade50,
            highlightColor: Colors.grey[100]!,
            direction: ShimmerDirection.ltr,
            child: Container(
              width: 250.0,
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
