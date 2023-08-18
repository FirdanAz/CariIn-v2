// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHomeAppBar extends StatelessWidget {
  const ShimmerHomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: CircleAvatar(
                radius: 25,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 27,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 200,
                    height: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class ShimmerWorkerList extends StatelessWidget {
  const ShimmerWorkerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
          height: 250,
          margin: const EdgeInsets.only(top: 15),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            padding: const EdgeInsets.only(left: 10),
            itemBuilder: (context, index) {
              return Container(
                width: 160,
                height: 230,
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 10),
                color: Colors.cyan,
              );
            },
          )),
    );
  }
}

class ShimmerHomeCard extends StatelessWidget {
  const ShimmerHomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.maxFinite,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

class ShimmerJobCard extends StatelessWidget {
  const ShimmerJobCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            width: double.maxFinite,
            height: 170,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.cyan,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
          );
        },
      ),
    );
  }
}

class ShimmerPelamar extends StatelessWidget {
  ShimmerPelamar({Key? key, required this.itemCount}) : super(key: key);
  int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            width: double.maxFinite,
            height: 70,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
          );
        },
      ),
    );
  }
}

class ShimmerTextHomeCard extends StatelessWidget {
  const ShimmerTextHomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 150,
                height: 30,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(2)),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                width: 200,
                height: 25,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(2)),
              ),
            ),
          ],
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 100,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(2)),
          ),
        ),
      ],
    );
  }
}

class ShimmerHomeIconCard extends StatelessWidget {
  const ShimmerHomeIconCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2)),
      ),
    );
  }
}

class CustomShimmer extends StatelessWidget {
  CustomShimmer({Key? key, required this.width, required this.height, required this.radius}) : super(key: key);
  double width;
  double height;
  double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(radius)),
      ),
    );
  }
}


