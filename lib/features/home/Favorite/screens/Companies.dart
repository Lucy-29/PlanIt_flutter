import 'package:ems_1/common/widgets/company_card.dart';
import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:flutter/material.dart';

class Companies extends StatelessWidget {
  List<CompanyCard> companies = [
    CompanyCard(
        companyModel: CompanyModel(
            companyName: "name",
            companyImageUrl:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1-7ZMt3JjvdNhnub36ahRq8gIAB5DbEZysw&s",
            discription: "discription",
            location: "location",
            
            ))
  ];
  @override
  Widget build(BuildContext context) {
    if (companies.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          Image.asset(
            "assets/images/favorite.png",
            height: 330,
            width: 330,
          ),
          Text("no liked companies!")
        ]),
      );
    } else {
      return ListView.builder(
          itemCount: companies.length,
          itemBuilder: (context, i) {
            return companies[i];
          });
    }
  }
}
