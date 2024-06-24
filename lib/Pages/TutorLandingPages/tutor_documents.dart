import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:darasni/Controllers/AuthenticationController/auth_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TutorDocuments extends StatelessWidget {
  const TutorDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: AppButton(
          "Submit",
          onTap: () {
            authController.updateDocuments();
          },
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Documents",
          style: AppTStyle.primaryStyle12.copyWith(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: AppTheme.secondaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GetBuilder(
        builder: (AuthenticationController controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  showImage(
                    file: controller.certificatesImage,
                    title: "Certificates",
                    image: authController.tutorProfileModel?.profileData?.certification ?? "",
                    onTap: () {
                      controller.getCertificates();
                    },
                    onDelete: () {
                      controller.certificatesImage = null;
                      controller.update();
                    },
                  ),
                  showImage(
                    file: controller.cPRDocumentImage,
                    title: "CPR Documents",
                    image: authController.tutorProfileModel?.profileData?.cpr ?? "",
                    onTap: () {
                      controller.getCPRDocument();
                    },
                    onDelete: () {
                      controller.cPRDocumentImage = null;
                      controller.update();
                    },
                  ),
                  showImage(
                    file: authController.passportImage,
                    title: "Passport Picture",
                    image: authController.tutorProfileModel?.profileData?.passportPic ?? "",
                    onTap: () {
                      controller.getPassport();
                    },
                    onDelete: () {
                      controller.passportImage = null;
                      controller.update();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showImage({
    String title = "",
    required String image,
    required VoidCallback onTap,
    required VoidCallback onDelete,
    String? file,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style:
                      AppTStyle.primaryStyle12.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Tap for change file",
                      style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            file != null
                ? Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        height: Get.height * .25,
                        width: Get.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(
                                File(file),
                              ),
                            ),
                            border: Border.all(
                              width: 1,
                              color: AppTheme.secondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      Positioned(
                          right: 0,
                          child: GestureDetector(
                            onTap: onDelete,
                            child: CircleAvatar(
                              backgroundColor: AppTheme.primaryColor,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  )
                : CachedNetworkImage(
                    httpHeaders: {
                      "Authorization": "Bearer ${authController.getUser()?.token}",
                    },
                    imageUrl: "${image}",
                    imageBuilder: (context, imageProvider) => Container(
                      height: Get.height * .25,
                      width: Get.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(
                            width: 1,
                            color: AppTheme.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          height: Get.height * .25,
                          width: Get.width,
                        )),
                    errorWidget: (context, url, error) => Container(
                      child: Center(
                          child: Text(
                        "No Preview Available",
                        style: AppTStyle.secondaryStyle12.copyWith(fontSize: 14),
                      )),
                      height: Get.height * .25,
                      width: Get.width,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: AppTheme.secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
