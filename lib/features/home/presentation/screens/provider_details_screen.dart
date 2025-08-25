import 'dart:ui';
import 'package:ems_1/common/widgets/provider_offer_card.dart';
import 'package:ems_1/common/widgets/provider_rate_card.dart';
import 'package:ems_1/common/widgets/service_card.dart';
import 'package:ems_1/common/widgets/show_guest_alert.dart';
import 'package:ems_1/features/auth/data/models/rating_bar_widget.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/home/data/models/provider_rate_model.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:ems_1/features/home/presentation/cubit/provider_request/request_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/Reserve_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProviderDetails extends StatefulWidget {
  final ServiceProviderModel serviceCard1;
  ProviderDetails({required this.serviceCard1});
  @override
  State<StatefulWidget> createState() =>
      ProviderDetailsScreen(serviceCard: serviceCard1);
}

class ProviderDetailsScreen extends State<ProviderDetails> {
  final ServiceProviderModel serviceCard;
  ProviderDetailsScreen({required this.serviceCard});
  int selectedIndex = 0;
  final List<String> tabs = ['ABOUT', 'OFFERS', 'REVIEWS'];
  List<ProviderRateCard> rates = [];
  final TextEditingController _commentController = TextEditingController();
  double numOfStars = 0;
  double totalrate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          serviceCard.providerName,
          style: TextStyle(fontSize: 25),
        ),
        toolbarHeight: 70,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, right: 15, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD99A9A).withOpacity(0.2),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: Color(0xffD99A9A),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(serviceCard.providerImageUrl),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Center(
            child: Text(
              serviceCard.providerName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBarIndicator(
                    rating: totalrate,
                    itemBuilder: (context, index) => Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30.0,
                    itemPadding: EdgeInsets.all(2.4),
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        expand: false,
                        context: context,
                        builder: (context) => Material(
                              borderRadius: BorderRadius.circular(90),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffF0CACA),
                                    borderRadius: BorderRadius.circular(40)),
                                height: 300,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    Container(height: 15),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.facebookF,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                color: Color(0xff858282)
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SelectableText(
                                                  serviceCard.facebookUrl,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: serviceCard
                                                        .facebookUrl));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text("copied!"),
                                                ));
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.copy,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                size: 30,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.instagram,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                color: Color(0xff858282)
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SelectableText(
                                                  serviceCard.instagramUrl,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: serviceCard
                                                        .instagramUrl));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text("copied!"),
                                                ));
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.copy,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                size: 30,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        spacing: 10,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.at,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: 50,
                                            width: 250,
                                            decoration: BoxDecoration(
                                                color: Color(0xff858282)
                                                    .withOpacity(0.6),
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SelectableText(
                                                  serviceCard.email,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: serviceCard.email));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text("copied!"),
                                                ));
                                              },
                                              icon: Icon(
                                                FontAwesomeIcons.copy,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                                size: 30,
                                              ))
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xffD99A9A),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel"),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Container(
                    height: 55,
                    width: 170,
                    decoration: BoxDecoration(
                        color: Color(0xff206173),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_add_alt_1_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                            height: 10,
                          ),
                          Text(
                            "Follow",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 19,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider(
                          create: (_) => RequestCubit(),
                          child: ReserveProvider( provider: serviceCard),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 55,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border:
                            Border.all(color: Color(0xffD99A9A), width: 1.7)),
                    child: Text("Reserve now",
                        style: TextStyle(
                          color: Color(0xffD99A9A),
                          fontWeight: FontWeight.w300,
                          fontSize: 19,
                        )),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(tabs.length, (index) {
                bool isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Color(0xff206173).withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: isSelected
                            ? Color(0xff206173)
                            : Color(0xff206173).withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0.0, 0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                key: ValueKey<int>(selectedIndex),
                child: _buildTabContent(selectedIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return _buildAbout();
      case 1:
        return _buildOffers();
      case 2:
        return _buildReviews();
      default:
        return SizedBox();
    }
  }

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          serviceCard.description,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "Work Gallery",
          style: TextStyle(
              color: Color(0xff206173),
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ),
        Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: 200,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: serviceCard.gallery.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(4),
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(
                          image: NetworkImage(serviceCard.gallery[i]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget _buildOffers() {
    if (serviceCard.offers.isEmpty) {
      return Center(
        child: Text("No offers available"),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: serviceCard.offers.length,
        itemBuilder: (context, i) {
          return ProviderOfferCard(
            providerOfferModel: serviceCard.offers[i],
            providerModel: serviceCard,
          );
        },
      );
    }
  }

  Widget _buildReviews() {
    final authState = context.watch<AuthCubit>().state;
    final isGuest = authState is Authenticated && authState.isGuest;
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: (rates.isEmpty)
              ? Text("no rates yet!")
              : ListView.builder(
                  itemCount: rates.length,
                  itemBuilder: (context, i) {
                    return rates[i];
                  },
                ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff206173),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            isGuest
                ? showGuestAlert(context)
                : AwesomeDialog(
                    context: context,
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'RATE',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xff206173),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffa0c4c7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              controller: _commentController,
                              minLines: 1,
                              maxLines: 2,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "ADD COMMENT......",
                                hintStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          RatingBar(
                            initialRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            ratingWidget: RatingWidget(
                              full: Icon(Icons.star, color: Colors.amber),
                              half: Icon(Icons.star_half, color: Colors.amber),
                              empty:
                                  Icon(Icons.star_border, color: Colors.amber),
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                numOfStars = rating;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    dialogType: DialogType.noHeader,
                    animType: AnimType.scale,
                    btnOkOnPress: () {
                      ProviderRateCard rateCard = ProviderRateCard(
                        providerRateModel: ProviderRateModel(
                          comment: _commentController.text,
                          numOfStars: numOfStars,
                        ),
                      );

                      setState(() {
                        rates.add(rateCard);
                        for (var rate in rates) {
                          totalrate += rate.providerRateModel.numOfStars;
                        }
                        totalrate = totalrate / rates.length;
                      });

                      _commentController.clear();
                      numOfStars = 0;
                    },
                  ).show();
          },
          child: Text("add rate"),
        ),
      ],
    );
  }
}
