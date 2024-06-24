import 'package:darasni/Widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FormLoading extends StatelessWidget {
  const FormLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: AppFormField(),
    );
  }
}
