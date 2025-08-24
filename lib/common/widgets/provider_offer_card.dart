import 'package:ems_1/common/widgets/show_guest_alert.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/home/data/models/provider_offer_model.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/features/home/presentation/screens/OfferDetails_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProviderOfferCard extends StatelessWidget {
  final ProviderOfferModel providerOfferModel;
  final ServiceProviderModel providerModel;
  const ProviderOfferCard({
    super.key, 
    required this.providerOfferModel,
    required this.providerModel,
  });
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isGuest = authState is Authenticated && authState.isGuest;
    return InkWell(
      onTap: () {
        isGuest
            ? showGuestAlert(context)
            : Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OfferdetailsScreen(
                          offerModel: providerOfferModel,
                          providerModel: providerModel,
                        )));
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
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
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
