import 'package:ems_1/features/home/data/models/provider_offer_model.dart';
import 'package:ems_1/features/home/presentation/screens/OfferDetails_Screen.dart';
import 'package:flutter/material.dart';

class ProviderOfferCard extends StatelessWidget {
  final ProviderOfferModel providerOfferModel;
  const ProviderOfferCard({super.key, required this.providerOfferModel});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OfferdetailsScreen(offerModel: providerOfferModel,) ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 15),
        child: Container(
          height: 110,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, offset: Offset(2, 2), blurRadius: 10)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      providerOfferModel.imageUrl,
                      height: 100,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      providerOfferModel.offerName,
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        '${providerOfferModel.price}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff50C878)),
                      ),
                    ]),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, right: 8.0),
                  child: InkWell(
                    child: Container(
                      height: 30,
                      width: 18,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 6),
                                blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.circular(40),
                          color: Color(0xff50C878)),
                      child: Center(
                          child: Text(
                        "RESERVE",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
