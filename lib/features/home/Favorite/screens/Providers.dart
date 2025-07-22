import 'package:ems_1/common/widgets/service_card.dart';
import 'package:flutter/material.dart';

class Providers extends StatelessWidget {
  List<ServiceCard> providers = [];
  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          Image.asset(
            "assets/images/favorite.png",
            height: 330,
            width: 330,
          ),
          Text("no liked providers!")
        ]),
      );
    }
    return ListView.builder(
        itemCount: providers.length,
        itemBuilder: (context, i) {
          return providers[i];
        });
  }
}
