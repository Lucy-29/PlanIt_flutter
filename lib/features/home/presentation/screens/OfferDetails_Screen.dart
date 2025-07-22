import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ems_1/features/home/data/models/provider_offer_model.dart';
import 'package:flutter/material.dart';

class OfferdetailsScreen extends StatelessWidget {
  ProviderOfferModel offerModel;
  OfferdetailsScreen({super.key, required this.offerModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: 40,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            AwesomeDialog(
                dialogType: DialogType.noHeader,
                animType: AnimType.scale,
                btnOkOnPress: () {},
                btnCancelOnPress: () {},
                btnOkText: "CONFIRM",
                btnCancelText: "CANCEL",
                btnOkColor: Color(0xff206173),
                btnCancelColor: Color(0xff206173).withOpacity(0.5),
                context: context,
                body: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(offerModel.offerName,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                      Text(offerModel.price,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff50C878)))
                    ],
                  ),
                )).show();
          },
          backgroundColor: Color(0xff50C878),
          child: Center(
              child: Text(
            "RESERVE",
            style: TextStyle(color: Colors.white),
          )),
        ),
      ),
      appBar: AppBar(
        title: Text(
          "offer Details",
          style: TextStyle(fontSize: 26),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 350,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)),
              child: Image.network(
                offerModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 2, left: 8),
            child: Text(
              offerModel.offerName,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(offerModel.price,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff50C878))),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 20, left: 8),
            child: Text(offerModel.offerDiscription,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                )),
          )
        ],
      ),
    );
  }
}
