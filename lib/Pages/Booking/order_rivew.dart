import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';

import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/order_review_card.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ProfilePage/view_tutor_profile_page.dart';
import '../StudentLandingPages/student_tab_page.dart';
import 'payment_methiod_page.dart';

class CartsReviewPage extends StatefulWidget {
  const CartsReviewPage({super.key});

  @override
  State<CartsReviewPage> createState() => _CartsReviewPageState();
}

class _CartsReviewPageState extends State<CartsReviewPage> {
  @override
  void initState() {
    bookingController.viewCart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (BookingController controller) {
            if ((controller.cartsModelList?.data?.length ?? 0) < 1) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.back();

                // Get.to(() => StudentLandingPage());
                // Get.to(() => ViewTutorProfilePage(tutor: tutors));
              });
            }

            return AppButton("Continue to Payment",
                onTap:controller.cartsModelList != null
                    ? () {
                        Get.to(() => PaymentMethodPage());
                  // Get.offAll(StudentLandingPage());
                      }
                    : null);
          },
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "Order Review",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "*",
                  style: AppTStyle.primaryStyle12.copyWith(),
                ),
                const SizedBox(width: 2.5),
                Expanded(
                  child: Text(
                    "If you don’t complete your payment "
                    "within 30 minutes, the bookings added "
                    "in your cart will be automatically deleted",
                    style: AppTStyle.secondaryStyle12.copyWith(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(height: 1, color: AppTheme.appGreyColor),
            const SizedBox(height: 30),
            GetBuilder(
              builder: (BookingController controller) {
                return controller.cartsModelList != null
                    ? Expanded(
                        child: ListView.builder(
                        itemCount: controller.cartsModelList?.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return OrderReviewCard(
                            controller.cartsModelList?.data?[index],
                            onDelete: () async {
                              await showAlertDialog().then((value) {
                                if (value)
                                  controller.deleteCart(controller.cartsModelList?.data?[index].id);
                                if ((controller.cartsModelList?.data?.length ?? 0) < 1) {
                                  Get.offAll(StudentLandingPage());
                                }
                              });
                            },
                          );
                        },
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> showAlertDialog() async {
    bool res = false;

    await showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: AlertDialog(
              title: Row(
                children: [
                  Text("Are you sure you want to ",
                      style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16)),
                  Text("Delete?", style: AppTStyle.primaryStyle12.copyWith(fontSize: 16))
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'No',
                    style: AppTStyle.secondaryStyle12.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    res = false;
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'Yes',
                    style: AppTStyle.primaryStyle12.copyWith(fontSize: 16),
                  ),
                  onPressed: () {
                    res = true;

                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    return res;
  }
}
