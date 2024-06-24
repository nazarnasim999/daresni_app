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

class Pricing extends StatelessWidget {


  const Pricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pricing Policy",
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
                      Text(
                        "1. General Terms & Conditions​",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),


                      const SizedBox(height: 10),
                      Text(
                        "Daresni Education and Training “Daresni”, is an online web-based booking platform that connects Tutors/Coaches “Tutor(s)” with Users/Users “Users” in the Kingdom of Bahrain. ",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),

                      Text(
                        "Daresni also provides a web-based booking platform for Individuals & Institutes to advertise specific academic, music or sporting courses & camps of any size at a public rate. ",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),

                      Text(
                        "Herein, the definition of Tutor(s) pertains to a private teacher, typically one who teaches a single pupil or a very small group. There are no limitations on public Tutor(s) advertised on the platform. However, Daresni reserves the right to determine the feasibility, validity, Daresni certification and approval of any Tutor advertised on the platform.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "A “Coach” will pertain an active individual whom supports a learner, student, User or client in achieving a specific personal or professional goal by providing training and guidance. There are no limitations on public Coach(es) advertised on the platform. However, Daresni reserves the right to determine the feasibility, validity, Daresni certification and approval of any Coach advertised on the platform.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "An “Institute” will pertain to an active individual or organization having a particular purpose or group of services, especially one that is involved with science, education, arts, music, sports or a specific profession. Institutes with an active Ministry of Education License are provided with a public Daresni “certified” stamp. There are no limitations on public courses advertised on the platform. However, Daresni reserves the right to determine the feasibility, validity, Daresni certification and approval of any Institute or Course advertised on the platform. ",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "A “Course” will pertain to a set of classes or a plan of study on a particular subject, usually leading to an exam or qualification. A Course may be offered by certified & non-certified individuals. Any Course that has an active Ministry of Education License, are provided with a Daresni “certified” stamp. Daresni does not & will not allow any Institute or individual to offer any certification to Users on the platform, unless otherwise authorized by the Ministry of Education in Bahrain. ",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "A “Camp” will pertain to a place where children or adults can go, usually to stay, and do educational, sporting, arts, or music activities. A Camp could pertain to Summer & Winter Camps, as well as other seasonal, educational or sporting activities.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "Our license is 120812- 1 and Date of issue: 29 March 2018. 1st Revision Date: 30 October 2019.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "The following is a legal agreement between you (“you”, “Student”, “Guardian”, “Parent” or “User/s”) and the owners and operators (“we”, “us”, or “Daresni Education & Training”) of the site at daresni.net (the Website”) and all related activities, services booked within any industry or category via any and or all websites, software, mobile apps, and other services that we provide (together, the “Service”).",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),





                      Text(
                        "Your use of the Service(s) offered via the Website, and our provision of the Service to you, constitutes as agreement by you and Daresni to be bound by the terms and conditions in these Terms of Service (“Terms”).",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "“Service/s” shall refer collectively to all services offered by Coaches or are acknowledged and/or received through the Website to all Users.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(

                        "We deserve the right, at our sole discretion, to change or modify portions of these Terms at any time. If we do this, we will post the changes on this page and will indicate at the top of this page the date these Terms were last revised. Any such changes will become effective immediately. Your continued use of the Service after the date any such changes become effective constitutes your acceptance of the new terms.",
                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      const SizedBox(height: 30),
                      Text(
                        "2. Requirements and Registration",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),


                      Text(

                        "You may use this Service(s) only if you form a binding contract with Daresni, and only in compliance with these Terms and all applicable laws, rules, and regulations. The Service(s) is not available to any Users previously removed from the Service by Daresni. You will be required to register with us in order to access and use certain features of the Service(s). Once you register for the Service(s) you agree to provide and maintain true, accurate, and current information as prompted by the Service’s registration form.",

                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "Registration data and certain other information about you are governed by our Privacy Policy. If you are under 18 years old, you may use the Service only with the approval of your parent, guardian or teacher.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      const SizedBox(height: 30),
                      Text(
                        "3. Use of Service",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),



                      Text(
                        "In connection with your use of Service, you will not engage in or use any data mining robots, similar data gathering or extraction methods. The technology and software underlying the Service or distributed in connection therewith is the property of Daresni and our licensors, affiliates and our partners.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "You agree not to copy, modify, create a derivative work of, reverse engineer, reverse assemble or otherwise attempt to discover any source code, sell, assign, sublicense, or otherwise transfer any right in such technology or software. Any rights not expressly granted herein are reserved by Daresni.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "You may upload images to your personal profile on the Website, and Daresni will screen these contents to see if they are suitable for public viewing. You are solely responsible for the Content you upload. You acknowledge that Daresni does not allow the upload of any Images that infringe on any copyright, property right, trademark, or any other applicable right.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "You accept that even though we do our best to prevent it from happening, Daresni cannot be held responsible for the misuse or abuse of any Content or Service(s) offered by registered Coaches, Courses or Camps. ",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "We also reserve the right to remove any Content and or Service at any time we believe it is defective, unrealistic, offensive, or misrepresentative, or in violation of these Terms.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      const SizedBox(height: 30),
                      Text(
                        "4. Using and Booking Services on Platform",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),


                      Text(
                        "Daresni Education and Training “Daresni”, is an online web-based booking platform that connects Tutors/Coaches “Tutor(s)” with Students/Users “Users” in the Kingdom of Bahrain. ",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),




                      Text(
                        "Daresni also provides a web-based booking platform for Individuals & Institutes to advertise specific academic, music or sporting courses & camps of any size at a public rate. ",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "Our license is 120812- 1 and Date of issue: 29 March 2018. 1st Revision Date: 30 October 2019.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "Daresni offers a web based service to connect individuals in the Kingdom of Bahrain and is not responsible for any behavior conducted outside the terms of service between Coaches and Users. You accept that even though we do our best to prevent it from happening, Daresni cannot be held responsible for the misuse or abuse of any Content or Service(s) offered by Users, Coaches, Institutes, Courses or Camps.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),




                      Text(
                        "Daresni offers a system whereby sessions can be booked and provided in a non-official capacity. It is not an educational institution and will not, in any circumstance allow its Coaches, Institutes or Private Individuals to provide any legal certification in any form to its Users.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "Daresni will manage payment of Services to include individual hourly sessions, Course & Camp fees and will be the intermediary between Tutors, Coaches, Institutes, Courses and Users. Daresni offers private lessons of all educational and non- educational capacities. For the purposes of these conditions, person(s) who proceeds to register as a Tutor, Coach, Institute or Private Individual offering a Course on Daresni may or may not be certified as an official or licensed individual or organization in the Kingdom of Bahrain. Person(s) registered on Daresni will be mandated to declare whether they are certified or not certified. All registered person(s) will be documented as “uncertified” until a cross-check and necessary KYC process of official uploaded documentation is completed. Once cross-checked & KYC is complete, Daresni will ensure the profile is updated to “certified” which will reflect on the profile page and via search engine on the Service.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "Tutor(s), Coach(es), Institute(s) & Private Individual(s) can charge a reasonable price of which they deem appropriate for conducting their service(s). Users, upon completing a service booking on the platform, acknowledge and agree to the charge associated with each service or course by confirming the booking on the platform and completing payment. A receipt is sent by email with all confirmed details pertaining to the successful booking completion. ",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "Upon confirmation of any service under Daresni’s Home Tutor or Coach section, a Tutor will receive an alert containing all information pertaining to the service booking by the User. It is mandatory for any Tutor to transit to the location of the service booking to complete a transaction. No transaction will be complete if the Tutor does not provide a service/upon no-show without reasonable explanation, or cancellation without notice. Please refer to Section 5 for more information on the Cancellation Policy.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "Upon confirmation of any service under Daresni’s Institutes, Coach & Camps section, an Institute or Private Individual will receive an alert containing all information pertaining to the Course or Camp booking by the User. It is expected that any User transit to the location of the Institute or Camp to complete the service offering. It is not mandatory for Users to complete and attend any part or all of Course or Camp dates booked. Attendance is in accordance to Users’ discretion. No transaction is complete if the Institute or Private Individual does not provide services offered under Course details as per the publicly advertised information. Please refer to Section 5 for more information on the Cancellation Policy.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "A User should be a person(s) aged 18+ and should be a responsible adult. Parents or guardians acting on behalf of a minor should be aware of the dangers surrounding engaging person(s) who they have not engaged with in any capacity and should take necessary precautions in this regard.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        "It is mandatory to ensure there is a suitable adult present during any session for Users conducted for children under the age of 18 years for any Service. Daresni cannot be held responsible for the misuse or abuse of any Content or Service(s) offered by Tutors, Institutes & Private Individuals.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "Upon accepting the terms, Tutor(s), Institute(s) & Private Individual(s) will be committed to the sessions booked via the Daresni online web-based platform. Both the Tutor, Institute and User may cancel a booking created within a specific time-frame prior to the scheduled booking and receive a full, partial or no refund. Please refer to the Cancellation Policy in Section 5 below for further details.",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),

                      const SizedBox(height: 30),
                      Text(
                        "5. Pricing and Cancellation Policy",
                        style: AppTStyle.secondaryStyle12
                            .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),


                      Text(
                        "5.1 User General Terms of Service, Pricing, Refund and Cancellation Policy",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        "The following is a legal agreement between you (“you”, “Student”, “Guardian”, “Parent” or “User/s”) and the owners and operators (“we”, “us”, or “Daresni Education & Training”) of the site at daresni.net (the “Website”) and all related activities, services booked within any industry or category via any and or all websites, software, mobile apps, and other services that we provide (together, the “Service”).",


                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(height: 10,),


                      Text(
                        ". As a registered or not registered User selecting and completing a booking with Daresni, you agree and are bound by the Terms in the full agreement documented as “Daresni Education & Training “Daresni” General Terms of Service & Policies”.",



                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ". A User should be a person(s) aged 18+ and should be a responsible adult. Parents or guardians acting on behalf of a minor should be aware of the dangers surrounding engaging person(s) who they have not engaged with in any capacity prior to bookings and should take necessary precautions in this regard. It is mandatory to have a User’s parent, guardian or responsible adult present during any session booked using the Daresni platform.",



                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ". A User agrees to be responsible for ensuring that the provision of Tutor services can be completed in a suitable environment. A User is also solely responsible for ensuring appropriate supervision is in place throughout any and all booked Service sessions.",



                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        ". It is important to note, that Daresni offers a flexible pricing policy to Tutors. Tutors will cost their Service based upon their own credentials, market demand and competition. Pricing does not and will not reflect upon Daresni evaluation of Service(s) provided by Tutors registered on the platform. Users reserve the right to book a Service(s) based on Tutor(s) advertised rate upon searching for particular Service(s).",



                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        ". A User bears all responsibility of booking Tutor(es) bearing in mind all available certified and non-certified information, ratings and reviews available at time of booking.",



                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(

                        ". Daresni will ensure information is accurate and credible and will adhere to enforce all policies and procedures to the best of their capabilities.",



                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        ". Daresni is not liable for any incorrect or inaccurate information uploaded to the platform by Tutor(s) registered on the platform.",




                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(

                        ". Users accept that, while Daresni always endeavor to ensure that Service(s) are provided to the highest standard possible, Daresni does not guarantee any success or specific results.",




                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ". Users understand and acknowledge that once Service(s) are booked, payment completed and confirmed, Session(s) must be cancelled more than 24 hours in advance of confirmed booking date and time in order to receive a complete and full refund.",





                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ". Any Service(s) cancellation less than 24 hours before a booked session will be refunded the advertised and confirmed amount, less 10% service fee.",





                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),


                      Text(
                        ". If the Tutor does not provide a service/upon no-show without reasonable explanation, or cancellation without notice, the payment will be refunded completely and in full to the User.",





                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ". The User understands that Tutors reserve the right to cancel any booked session, even after payment, within a specific time frame and the User will be provided with a full refund.",





                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ".Every User will be prompted to rate a Tutor upon service completion which will act as a “confirmation of service completion”.",





                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),



                      Text(
                        ". Ratings reflect the standard and quality of a Tutor. A User is encouraged to rate Tutor(es) fairly and accurately, in order to provide feedback opportunities for both other Users and Tutor in the Daresni community.",





                        style: TextStyle(
                          fontSize: 12.0, // Set the font size


                        ),
                        textAlign: TextAlign.justify,
                      ),




                       SizedBox(height: 30,),
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
