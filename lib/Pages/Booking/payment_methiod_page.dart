import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Plugins/Paypal/flutter_paypal.dart';
import 'package:darasni/Plugins/TapPayment/flutter_tap_payment.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  final String _paypalClientId =
  // "AQYeE2AW65InmnmqGQlzvz0lbbzOc9hgxsAgdVxvTsGpHQUJDRdwBEsvZtGqckA0pkXk7b2Qfw6QwQxw";
      "AbmLHIGY-7-tlW3l0iGB-13Pf5Q59cxOugHsDfAl90MGCy7GtBtgUF7RMCf93X5w0hBrokEnJApu3vFA";
  final String _paypalSecretKey =
      "EM2FW4a0lvnp9PcXfJWHJ3oNdXIAGtdIZTohufbPeNwlJ1fQlBUjNlx0QywIrll4rzkLsSTrUCNTAJJf";

  // "EGHpgvlC1t5ZoURjEJNfisfwZxTFpu716wNvhJAaAO4m5ntbTPHB8f_Xrzgx3N9Gqt0x1bkWgmFzf6lv";
  final String _tapAPiKey = "sk_test_NxIJj0ysk75bapzdPELHR86G";

  @override
  Widget build(BuildContext context) {
    logger.i(bookingController.tapResponse?.id);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (BookingController controller) {
            return AppButton(
              "Continue",
              onTap: controller.paymentMethod == null
                  ? null
                  : () {
                handlePaymentMethod(context);
              },
            );
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
            Text(
              "Payment Method",
              style: AppTStyle.primaryStyle12.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(child: GetBuilder(
              builder: (BookingController controller) {
                return ListView.builder(
                  itemCount: controller.paymentMethodList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.paymentMethod !=
                                controller.paymentMethodList[index]
                                ? AppTheme.appGreyColor
                                : AppTheme.primaryColor,
                            width: 1.0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: RadioListTile(
                        dense: true,
                        toggleable: true,
                        activeColor: AppTheme.primaryColor,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(controller.paymentMethodList[index]),
                        value: controller.paymentMethodList[index],
                        groupValue: controller.paymentMethod,
                        onChanged: (v) {
                          controller.paymentMethod = v.toString();
                          controller.update();
                        },
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  void handlePaymentMethod(context) {
    double total = 0.0;
    List items=[];

    bookingController.cartsModelList?.data?.forEach((element) {
      total = total + double.parse(element.pricing??"0");
      items.add(
        {
          "name": element.subject
              ?.name?.en,
          "quantity": 1,
          "price": '${element.pricing??"0"}',
          "currency": element.priceSymbol ?? 'USD'
        }
      );
    });

    if (bookingController.paymentMethod == "Paypal") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              UsePaypal(
                sandboxMode: false,
                clientId: _paypalClientId,
                secretKey: _paypalSecretKey,
                returnURL: "https://samplesite.com/return",
                cancelURL: "https://samplesite.com/cancel",
                transactions: [
                  {
                    "amount": {
                      "total": '$total',
                      "currency": bookingController.cartsModelList?.data?.first.priceSymbol ?? 'USD',
                      "details": {
                        "subtotal": '$total',
                        "shipping": '0',
                        "shipping_discount": 0
                      }
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items":items,
                    }
                  }
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  logger.i(params);
                  bool res = bookingController.setPaypalResponse(params);
                  logger.i(bookingController.paypalResponse?.paymentId);

                  if (!res) {
                    AppAlerts.showSnack(
                        "Unable to proceed payment", error: true);
                    return;
                  }

                  Future.delayed(Duration(seconds: 1), () async {
                    await bookingController
                        .paymentForCartItem(
                        bookingController.paypalResponse!.paymentId!)
                        .then((res) {
                      // if (res) {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (BuildContext context) {
                      //     return ThankForBookingPage();
                      //   },
                      // ));
                      // }
                      return null;
                    });
                  });
                },
                onError: (error) {
                  logger.e("onError: $error");
                },
                onCancel: (params) {
                  logger.wtf('cancelled: $params');
                },
              ),
        ),
      );
    }
    else if (bookingController.paymentMethod == "Credit/Debit Card") {
      profileController.getProfile();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) =>
              TapPayment(
                apiKey: _tapAPiKey,
                redirectUrl: "http://google.com",
                postUrl: "http://google.com",
                paymentData: {
                  "amount": '${total}',
                  "currency": "BHD",
                  "threeDSecure": true,
                  "save_card": false,
                  "description": " Description",
                  "statement_descriptor": "Testing",
                  "metadata": {"udf1": "test 1", "udf2": "test 2"},
                  "reference": {"transaction": "txn_0001", "order": "ord_0001"},
                  "receipt": {"email": true, "sms": true},
                  "customer": {
                    "first_name": authController
                        .getUser()
                        ?.user
                        ?.name ?? "",
                    "middle_name": "",
                    "last_name": "",
                    "email": authController
                        .getUser()
                        ?.user
                        ?.email ?? "",
                    "phone": {
                      "country_code": "${profileController.studentProfile?.data
                          ?.contact?.countryCode}",
                      "number": "${profileController.studentProfile?.data
                          ?.contact?.contactNo}"
                    }
                  },
                  "source": {"id": "src_card"},
                },
                onSuccess: (Map params) async {
                  logger.i(params);
                  bookingController.setTapPaymentResponse(params);
                  Future.delayed(Duration(microseconds: 500), () async {
                    await bookingController
                        .paymentForCartItem(
                        bookingController.tapResponse!.id.toString())
                        .then((value) {
                      // if (value)
                      //   Navigator.pushReplacement(context,
                      //       MaterialPageRoute(builder: (BuildContext context) {
                      //     return ThankForBookingPage();
                      //   }));
                    });
                  });
                },
                onError: (error) {
                  logger.e("onError: $error");
                },
              ),
        ),
      );
    }
  }
}
