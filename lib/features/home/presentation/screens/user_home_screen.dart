import 'package:ems_1/common/widgets/custom_search_bar.dart';
import 'package:ems_1/common/widgets/invitefreinds.dart';
<<<<<<< HEAD
import 'package:ems_1/common/widgets/popular_widget.dart';
import 'package:ems_1/common/widgets/upoffers.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/data/models/offer_model.dart';
import 'package:ems_1/features/home/presentation/screens/notifications_screen.dart';
=======
import 'package:ems_1/common/widgets/popular_events_widget.dart';
import 'package:ems_1/common/widgets/service_provider_widget.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/data/models/service_card_model.dart';
>>>>>>> upstream/main
import 'package:flutter/material.dart';

class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});
  final List<OfferModel> offlist = [
    OfferModel(img: "assets/images/offer1.jpeg"),
    OfferModel(img: "assets/images/offer2.jpeg"),
    OfferModel(img: "assets/images/offer2.jpeg"),
  ];
  final List<EventCardModel> dummyList = [
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: 'Ted',
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: '100',
    ),
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: 'Ted',
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: '2000',
    ),
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: 'Ted',
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: '20',
    ),
    EventCardModel(
      imageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      title: 'test',
      date: '15 nov',
      location: 'Damascus',
      goingCount: 20,
      organizer: 'Ted',
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: '300',
    ),
  ];

  final List<ServiceCardModel> dummyServices = [
    ServiceCardModel(
      providerName: 'Salon Sarah',
      serviceName: 'Hair Styling & Beauty',
      location: 'Damascus',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Expert beauty services from trained professionals in a relaxing environment.',
    ),
    ServiceCardModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
    ),
    ServiceCardModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
    ),
    ServiceCardModel(
      providerName: 'FixIt Co.',
      serviceName: 'Home Repair Services',
      location: 'Homs',
      placeImageUrl:
          'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
      providerImageUrl:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      description:
          'Reliable home maintenance and repair for appliances and furniture.',
    ),
  ];
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
        child: Stack(
          children: [
            Upoffers(offList: offlist),
            Padding(
              padding: const EdgeInsets.only(top: 220),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  children: [
                    PopularWidget(event: dummyList),
                    Invitefreinds(),
                    // ListView.builder(itemBuilder: itemBuilder)
                  ],
                ),
=======
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  PopularEventsWidget(event: dummyList),
                  Invitefreinds(),
                  ServiceProviderWidget(serviceCardModel: dummyServices),
                ],
>>>>>>> upstream/main
              ),
            ),
            CustomSearchBar(),
          ],
        ),
      ),
    );
  }
}
