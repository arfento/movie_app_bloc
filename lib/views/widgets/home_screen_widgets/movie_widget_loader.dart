import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildMovielistLoaderWidget(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.black87,
    highlightColor: Colors.black54,
    enabled: true,
    child: Container(
      height: 150,
      padding: const EdgeInsets.only(left: 10),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 15),
            child: GestureDetector(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: SizedBox(
                      height: 140,
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.8,
                          decoration:
                              const BoxDecoration(color: Colors.black12),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
