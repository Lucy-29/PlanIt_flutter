import 'package:ems_1/common/widgets/provider_rate_card.dart';
import 'package:ems_1/features/home/data/models/provider_rate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RatingBarWidget extends StatefulWidget {
  const RatingBarWidget({super.key});
  @override
  State<StatefulWidget> createState() => RatingBarWidget1();
}

class RatingBarWidget1 extends State<RatingBarWidget> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4),
      itemBuilder: (BuildContext context, _) => Icon(
        FontAwesomeIcons.star,
        size: 10,
        color: Color(0xffD4AF37),
      ),
      onRatingUpdate: (double value) {
        
      },
    );
  }
}
