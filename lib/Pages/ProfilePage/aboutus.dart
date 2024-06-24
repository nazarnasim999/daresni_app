import 'dart:convert';

import 'package:darasni/Controllers/Booking%20Controller/booking_controller.dart';
import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/tutor_list.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/app_button.dart';
import 'package:darasni/Widgets/profile_dp.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Booking/select_subject.dart';

class AboutUs extends StatelessWidget {


  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(fontSize: 16,color: Colors.white),
        ),
        centerTitle: false,
        backgroundColor: AppTheme.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: Get.width,
          child: SingleChildScrollView(
            child: GetBuilder(

              builder: (BookingController controller) {

                return Container(

                  padding: EdgeInsets.only(left: 20 , right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [




                      const SizedBox(height: 30),



                      const SizedBox(height: 10),
                      Text(
                          "Daresni “teach me” is a web based platform founded in 2018 that connects an increasing number of teachers with students for physical, private, home sessions in the Kingdom of Bahrain. Essentially, Daresni is a tutor and coach services booking system whereby a student or user can find, book and pay for their private home session in advance. A student, parent or guardian can book home private tutoring sessions to their home based upon tutor availability and their own personal schedule. Tutors (either certified or uncertified) can register with Daresni, registering their level of certification, their subjects, and chargeable amount per hour. Apart from educational tutoring, Daresni offers sports lessons to include Martial arts, boxing, swimming, tennis, personal training lessons, various music tutoring sessions, art and much more! Daresni strives to spread knowledge and create jobs by creating a network of accessible resources, available to everyone, everywhere, and at any time in order to build a better future where private education is accessible to everyone!",
                        style: TextStyle(
                          fontSize: 15.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      const SizedBox(height: 20),
                      Container(height: 1, color: AppTheme.greyColor),
                      const SizedBox(height: 20),
                      Text(
                        "Principles & Values",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Our business model has been developed around the following RIPLE effect of core principles and values: 1) Respect - of both tutors and students 2) Integrity - of professional tutors and Coaches 3) Passion - on the job and its “pay it forward” philosophy in terms of education 4) Leadership - of educational providers for our next generation 5) Empathy - to understand student academic difficulties and run at their personal pace"  ,
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      const SizedBox(height: 20),
                      Text(
                        "How We Are Different",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          "Our uniqueness is our passion to create jobs for educated citizens and offer education to students with no limitations. Daresni offers a platform for a home based service by tutors/coaches based upon student/user personal requirements, empowering both students and tutors together.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,

                      ),




                      const SizedBox(height: 20),
                      Text(
                        "Global Coverage",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
"Daresni was founded in the Kingdom of Bahrain in 2018 with plans to expand the platform to neighboring countries in the GCC.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      const SizedBox(height: 20),
                      Text(
                        "Who We are & How We Work",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          "We are a platform of increasing number tutors/coaches, willing to provide their services, given their individual credentials. With a diverse network of tutors/coaches, students/users can access a wide range of educated individuals, selecting their tutor/coach based upon their individual requirements and budget. Bookings can be made on the platform by selecting and completing payment online.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                  "A confirmation will be sent to both parties once the booking is complete. The tutor/coach will receive the student details and transfer to the destination to complete the booked session. Students/users will pay the charge for the selected service(s) upon booking, however payout will be completed to the tutor/coach once the session(s) has been completed. Daresni will strive to ensure both parties adhere to the terms & conditions pertained to confirming services on the platform.",

                        style: TextStyle(
                        fontSize: 12.0, // Set the font size


                      ),
                        textAlign: TextAlign.justify,
                      ),



                      const SizedBox(height: 60),


                      Text(
                        "Copyright © 2024 Daresni - All Rights Reserved.",
                        style: TextStyle(
                          fontSize: 14.0, // Set the font size
                          fontWeight: FontWeight.bold, // Set the font weight
                          color: Colors.black, // Set the text color

                        ),
                      ),

                      const SizedBox(height: 20),


                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }


}
