import 'package:darasni/Controllers/controllers_init.dart';
import 'package:darasni/Models/AuthModels/login_model.dart';
import 'package:darasni/Pages/TutorLandingPages/tutor_profile.dart';
import 'package:darasni/Utils/utils.dart';
import 'package:darasni/Widgets/profile_dp.dart';
import 'package:darasni/strings_and_const.dart';
import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TutorHomePage extends StatelessWidget {
  TutorHomePage({super.key});

  final LoginModel? loginModel = authController.getUser();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: AppTheme.appGreyColor, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDP(
                        radius: 50,
                        imageUrl: loginModel?.user?.profilePicture,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                loginModel?.user?.name ?? "",
                                style: AppTStyle.secondaryStyle12
                                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              // const SizedBox(width: 10),
                              Image.asset(
                                ImageRes.assetsVerifiedUser,
                                height: 15,
                                width: 15,
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Expertise: ${loginModel?.user?.expertise?.name ?? ""}",
                            style: AppTStyle.secondaryStyle12
                                .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.pin_drop, color: AppTheme.primaryColor),
                              Text(
                                loginModel?.user?.nationality?.name ?? "",
                                style: AppTStyle.primaryStyle12
                                    .copyWith(fontSize: 10, fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: AppTheme.primaryColor,
                            ),
                            itemSize: 15,
                            onRatingUpdate: (rating) {
                              logger.i(rating);
                            },
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox.shrink()),
                      GestureDetector(
                        onTap: () {
                          homeController.changePage(3);
                        },
                        child: Text(
                          "Edit",
                          style: AppTStyle.primaryStyle12.copyWith(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Nationality : ",
                    style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    loginModel?.user?.nationality?.name ?? '',
                    style: AppTStyle.secondaryStyle12.copyWith(),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  GestureDetector(
                    onTap: () {
                      homeController.changePage(3);
                    },
                    child: Text(
                      "Edit",
                      style: AppTStyle.primaryStyle12.copyWith(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Experience : ",
                    style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${loginModel?.user?.workExperience} Years",
                    style: AppTStyle.secondaryStyle12.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Language : ",
                    style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    loginModel?.user?.primaryLanguage?.name?.en ?? "",
                    style: AppTStyle.secondaryStyle12.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Services : ",
                    style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Text(
                      loginModel?.user?.offerServices ?? "",
                      style: AppTStyle.secondaryStyle12.copyWith(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "My Price : ",
                    style: AppTStyle.primaryStyle12.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "BD-/ ${loginModel?.user?.pricing}",
                    style: AppTStyle.secondaryStyle12.copyWith(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(height: 1, color: AppTheme.greyColor.withOpacity(.6)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "About Me",
                    style: AppTStyle.secondaryStyle12.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      homeController.changePage(3);
                    },
                    child: Text(
                      "Edit",
                      style: AppTStyle.secondaryStyle12.copyWith(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                loginModel?.user?.bio ?? "",
              ),
              const SizedBox(height: 10),
              Container(height: 1, color: AppTheme.greyColor.withOpacity(.6)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Expertise in Subjects :",
                    style: AppTStyle.secondaryStyle12.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      pageNo=2;
                      homeController.changePage(3);
                    },
                    child: Text(
                      "Add/Edit Subjects",
                      style: AppTStyle.secondaryStyle12.copyWith(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Wrap(
                children: List.generate(loginModel?.user?.subjects?.length ?? 0,
                    (index) => subjects(loginModel?.user?.subjects?[index].name?.en ?? "")),
              )
            ],
          ),
        ));
  }

  Widget subjects(text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration:
                BoxDecoration(color: AppTheme.appGreyColor, borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    text,
                    style: AppTStyle.secondaryStyle12,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
