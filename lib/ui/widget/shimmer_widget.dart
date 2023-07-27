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
                Container(width: 100, height: 27, color: Colors.blue,),
                const SizedBox(height: 5,),
                Container(width: 200, height: 20, color: Colors.blue,),
              ],
            ),
          )
        ],
      )
    );
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
          )
      ),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
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
                bottomLeft: Radius.circular(10)
              )
            ),
          );
        },
      ),
    );
  }
}


