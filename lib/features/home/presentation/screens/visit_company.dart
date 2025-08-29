import 'dart:ui';
import 'package:ems_1/common/widgets/company_card.dart';
import 'package:ems_1/common/widgets/provider_rate_card.dart';
import 'package:ems_1/common/widgets/show_guest_alert.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/data/models/provider_rate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class VisitCompany extends StatefulWidget {
  final CompanyModel companyModel;
  VisitCompany({required this.companyModel});
  @override
  State<StatefulWidget> createState() =>
      VisitCompanyScreen(companyModel1: companyModel);
}

class VisitCompanyScreen extends State<VisitCompany> {
  final CompanyModel companyModel1;
  VisitCompanyScreen({required this.companyModel1});
  int selectedIndex = 0;
  final List<String> tabs = ['ABOUT', 'EVENTS', 'REVIEWS'];
  List<ProviderRateCard> rates = [];
  final TextEditingController _commentController = TextEditingController();
  double numOfStars = 0;
  double totalrate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          companyModel1.companyName,
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
                backgroundColor: Colors.grey[300],
                backgroundImage: (companyModel1.companyImageUrl.isNotEmpty)
                    ? NetworkImage(companyModel1.companyImageUrl)
                    : null,
                child: (companyModel1.companyImageUrl.isEmpty)
                    ? Icon(Icons.business, size: 40, color: Colors.white)
                    : null,
              ),
            ),
          ),
          Center(
            child: Text(
              companyModel1.companyName,
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
            padding: const EdgeInsets.only(left: 100, top: 8),
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
                                                  companyModel1.companyImageUrl,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: companyModel1
                                                        .companyImageUrl));
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
                                                  companyModel1.companyImageUrl,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: companyModel1
                                                        .companyImageUrl));
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
                                                  companyModel1.discription,
                                                  maxLines: 1),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Clipboard.setData(ClipboardData(
                                                    text: companyModel1
                                                        .discription));
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
                SizedBox(
                  width: 10,
                  height: 10,
                ),
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
        return _buildEvents();
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
          companyModel1.discription,
          style: TextStyle(fontSize: 17),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _buildEvents() {
    if (companyModel1.events.isEmpty) {
      return Center(
        child: Text(
          "  no events right now",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: companyModel1.events.length,
      itemBuilder: (context, i) {
        return CompanyCard(
          companyModel: companyModel1,
        );
      },
    );
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
