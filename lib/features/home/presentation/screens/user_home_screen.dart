import 'package:ems_1/common/widgets/custom_search_bar.dart';
import 'package:ems_1/common/widgets/invitefreinds.dart';
import 'package:ems_1/common/widgets/popular_events_widget.dart';
import 'package:ems_1/common/widgets/service_provider_widget.dart';
import 'package:ems_1/common/widgets/upoffers.dart';
import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/data/models/offer_model.dart';
//import 'package:ems_1/features/home/data/models/service_card_model.dart';
import 'package:ems_1/features/home/presentation/screens/notifications_screen.dart';
import 'package:ems_1/features/home/data/models/provider_offer_model.dart';
import 'package:ems_1/features/home/presentation/screens/notifications_screen.dart';
import 'package:ems_1/common/widgets/popular_events_widget.dart';
import 'package:ems_1/common/widgets/service_provider_widget.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/data/models/serviceprovider_model.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});
  final List<OfferModel> offlist = [
    OfferModel(img: "assets/lottie/offer1.json"),
    OfferModel(img: "assets/lottie/Time management.json"),
    OfferModel(img: 'assets/lottie/Core-Apps Associations.json'),
    OfferModel(img: 'assets/lottie/Calendar image animation.json'),
    OfferModel(img: "assets/lottie/offer2.json"),
    // OfferModel(img: 'assets/lottie/business-ideas.json'),
  ];
  final List<EventCardModel> dummyList = [
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location"),
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: 100,
      eventType: 'Wellness & Lifestyle 🧘',
    ),
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location"),
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: 2000,
      eventType: 'Entertainment & Fun 🎮',
    ),
    EventCardModel(
        imageUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
        title: 'test',
        date: '15 nov',
        location: 'Damascus',
        goingCount: 20,
        organizer: CompanyModel(
            companyName: 'S',
            companyImageUrl: 'companyImageUrl',
            discription: 'discription',
            location: 'location'),
        organizerImage:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
        desc:
            'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
        price: 20,
        eventType: 'Media & Content 📺'),
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location"),
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: 20,
      eventType: '',
    ),
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: CompanyModel(
          companyName: "companyName",
          companyImageUrl: "companyImageUrl",
          discription: "discription",
          location: "location"),
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: 300,
      eventType: '',
    ),
  ];

  final List<ServiceProviderModel> dummyServices = [
    ServiceProviderModel.withoffers(
      providerName: 'Salon Sarah',
      serviceName: 'Hair Styling & Beauty',
      location: 'Damascus',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          "https://i.pinimg.com/736x/5c/2c/71/5c2c71a48d6d1a166c529c2c9d2c7348.jpg",
      description:
          'Expert beauty services from trained professionals in a relaxing environment.',
      email: "Sara_Salon12@gmail.com",
      facebookUrl: "https://www.facebook.com/share/15hYNXKTc1/",
      instagramUrl: "https://www.instagram.com/instagram?igsh=Ym1sdzZmcDRjYTll",
      gallery: [
        "https://i.pinimg.com/736x/99/b1/14/99b114c8aebba9eaf7dcf32b2e0838ba.jpg",
        "https://i.pinimg.com/736x/13/23/a2/1323a2495b5b513df7ef6adb92815169.jpg",
        "https://i.pinimg.com/736x/6c/56/e6/6c56e6a5df1874f01180be399cdce30c.jpg",
        "https://i.pinimg.com/736x/99/b1/14/99b114c8aebba9eaf7dcf32b2e0838ba.jpg",
      ],
      offers: [
        ProviderOfferModel(
            imageUrl:
                "https://i.pinimg.com/736x/9f/57/16/9f5716bf58c4fad05f6c93d7a3887459.jpg",
            price: "150.000 S.P",
            offerDiscription: "offerDiscription",
            offerName: ' offer name .... ....'),
        ProviderOfferModel(
            imageUrl:
                "https://i.pinimg.com/736x/d5/34/0a/d5340a131bdc9f3c051696ed9bc6cdea.jpg",
            price: "200.000 S.P",
            offerDiscription: "offerDiscription",
            offerName: ' offer name .... ....'),
        ProviderOfferModel(
            imageUrl:
                "https://i.pinimg.com/736x/9f/57/16/9f5716bf58c4fad05f6c93d7a3887459.jpg",
            price: "150.000 S.P",
            offerDiscription: "offerDiscription",
            offerName: ' offer name .... ....'),
        ProviderOfferModel(
            imageUrl:
                "https://i.pinimg.com/736x/d5/34/0a/d5340a131bdc9f3c051696ed9bc6cdea.jpg",
            price: "200.000 S.P",
            offerDiscription: "offerDiscription",
            offerName: ' offer name .... ....')
      ],
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl: 'assets/images/Pretty Simple Headshot.jpeg',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl: 'assets/images/Pretty Simple Headshot.jpeg',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
    ServiceProviderModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl: 'assets/images/Pretty Simple Headshot.jpeg',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
      email: "",
      facebookUrl: "",
      instagramUrl: "",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PLANit"),
        // backgroundColor: Color(0xFFF4F2EA),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen()));
            },
            icon: Icon(
              Icons.notifications_outlined,
              // size: 30,
              // color: Color(0xFF206173),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Stack(children: [
        Upoffers(offList: offlist),
        Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  PopularEventsWidget(event: dummyList),
                  Invitefreinds(),
                  ServiceProviderWidget(serviceProviderModel: dummyServices),
                  // ListView.builder(itemBuilder: itemBuilder)
                ],
              ),
            )),
        CustomSearchBar(),
      ])),
    );
  }
}
