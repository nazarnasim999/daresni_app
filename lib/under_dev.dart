import 'package:darasni/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnderDev extends StatelessWidget {
  const UnderDev({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(onPressed: ()=>Get.back(),icon: Icon(Icons.arrow_back,color: Colors.white,),),),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sorry!",
              style: AppTStyle.secondaryStyle12.copyWith(fontSize: 18),
            ),
            Text(
              "this phase is under development",
              style: AppTStyle.primaryStyle12.copyWith(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
