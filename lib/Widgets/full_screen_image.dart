import 'package:cached_network_image/cached_network_image.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FullScreenImageView extends StatelessWidget {
  final String? image;

  const FullScreenImageView({this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: image != null
          ? Center(
              child: CachedNetworkImage(
                imageUrl: image!,
                imageBuilder: (context, imageProvider) => Container(
                  width: Get.width,
                  height: Get.height * .25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: AppTheme.secondaryColor),
                      image: DecorationImage(image: imageProvider)),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      height: Get.height * .25,
                    )),
                errorWidget: (context, url, error) => Container(
                  height: Get.height * .25,
                  width: Get.width,
                ),
              ),
            )
          : Center(
              child: Text(
                "No Image Available",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
    );
  }
}
