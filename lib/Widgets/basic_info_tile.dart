import '/Models/tutor_list.dart';
import '/Pages/ProfilePage/view_tutor_profile_page.dart';
import '/Widgets/profile_dp.dart';
import '/strings_and_const.dart';
import '/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BasicInfoTile extends StatelessWidget {
  final Tutors? tutors;

  const BasicInfoTile(this.tutors, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 1,
                color: const Color(0xffBFBFBF),
              )),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    ProfileDP(
                      radius: 35,
                      imageUrl: tutors?.profilePicture ?? "",
                    ),
                    if (tutors?.certified == 0)
                      Positioned(
                        right: 0,
                        child: Image.asset(
                          ImageRes.assetsVerifiedUser,
                          height: 20,
                          width: 20,
                        ),
                      )
                  ],
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: InkWell(
                    onTap: (){
                      Get.to(() => ViewTutorProfilePage(tutor: tutors));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Text(
                                tutors?.name ?? "",
                                style: AppTStyle.secondaryStyle12
                                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(width: 20),
                            RatingBar.builder(
                              initialRating: tutors?.rating?.toDouble() ?? 0.0,
                              // minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              itemCount: 5,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: AppTheme.primaryColor,
                              ),
                              itemSize: 10,
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),



                        SizedBox(height: 2.5),
                        Text(
                          "Price: BHD ${tutors?.pricing ?? ""}",
                          style: AppTStyle.secondaryStyle12
                              .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),


                        SizedBox(height: 2),
                        Text(
                          "Session Duration: 1 Hour",
                          style: AppTStyle.secondaryStyle12
                              .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),


                        SizedBox(height: 2.5),
                        Text(
                          "Language: ${tutors?.primaryLanguage?.name?.en ?? ""}",
                          style: AppTStyle.secondaryStyle12
                              .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),

                        SizedBox(height: 3.5),
                        Text(
                          "Expertise: ${truncateText(tutors?.expertise?.name?.en ?? "")}",
                          style: AppTStyle.secondaryStyle12
                              .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),


                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Session: ${getTeachingMode(tutors?.howToTeach)}",
                              style: AppTStyle.secondaryStyle12
                                  .copyWith(fontSize: 12, fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppTheme.secondaryColor, borderRadius: BorderRadius.circular(5)),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                child: Text(
                                  "View Profile",
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  String truncateText(String text) {
    if (text.length < 25) return text;

    return text.substring(0, 25) + '.....';
  }



  String getTeachingMode(String? mode) {
    if (mode == 'ps') {
      return 'Physical';


    }
    else if (mode == 'ph') {
      return 'Physical';
    }
    else if (mode == 'os') {
      return 'Online';
    }
    else if (mode == 'both') { // Assuming both values combined can be 'psos' or 'ops'
      return 'Physical, Online';
    } else {
      return 'Unknown'; // Default case if mode is not recognized
    }
  }
}
