import 'package:flutter/material.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/widgets.dart';

class PersonalInfo extends StatelessWidget {

  final String? image;
  final String name;
  final String jobTitle;

  const PersonalInfo({super.key, required this.image, required this.name, required this.jobTitle});

  @override
  Widget build(BuildContext context) {

    final titleOsw20Bold500Secondary = Theme.of(context).textTheme.titleOsw20Bold500Secondary;
    final textJt16bold400Grey = Theme.of(context).textTheme.textJt16bold400Grey;

    final fontSizedGrow = getResponsiveScaleFactor(context);
    

    return Row(
      children: [
        CirclePhoto(
          maxRadius: 30*fontSizedGrow,
          image: image!,
        ),
        const SizedBox(width: 10),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: titleOsw20Bold500Secondary.copyWith(
                  fontSize: 20*fontSizedGrow
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(jobTitle,style: textJt16bold400Grey.copyWith(
                  fontSize: 20*fontSizedGrow
                ),),
            ],
          ),
        ),
      ],
    );
  }
}