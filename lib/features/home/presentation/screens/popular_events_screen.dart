// import 'package:ems_1/common/widgets/event_card.dart';
// import 'package:ems_1/features/home/data/models/event_card_model.dart';
// import 'package:ems_1/features/home/presentation/screens/create_event/my_event_card.dart';
// import 'package:flutter/material.dart';

// class PopularEventsScreen extends StatelessWidget {
//   final List<EventCardModel> dummyList = [
//     EventCardModel(
//       imageUrl:
//           'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
//       title: 'test',
//       date: '15 nov',
//       location: 'Damascus',
//       goingCount: 20,
//       organizer: 'Ted',
//       organizerImage:
//           'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
//       desc:
//           'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
//       price: 100,
//     ),
//     EventCardModel(
//       imageUrl:
//           'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
//       title: 'test',
//       date: '15 nov',
//       location: 'Damascus',
//       goingCount: 20,
//       organizer: 'Ted',
//       organizerImage:
//           'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
//       desc:
//           'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
//       price: 100,
//     ),
//     EventCardModel(
//       imageUrl:
//           'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
//       title: 'test',
//       date: '15 nov',
//       location: 'Damascus',
//       goingCount: 20,
//       organizer: 'Ted',
//       organizerImage:
//           'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
//       desc:
//           'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
//       price: 100,
//     ),
//     EventCardModel(
//       imageUrl:
//           'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?q=80&w=1974',
//       title: 'test',
//       date: '15 nov',
//       location: 'Damascus',
//       goingCount: 20,
//       organizer: 'Ted',
//       organizerImage:
//           'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
//       desc:
//           'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
//       price: 22,
//     ),
//   ];

//   PopularEventsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Popular Events',
//           style: TextStyle(),
//         ),
//       ),
//       body: Column(
//         children: [
//           ListView.builder(
//               itemCount: dummyList.length,
//               itemBuilder: (context, index) {
//                 return EventCard(eventCardModel: dummyList[index]);
//               }),
//                ListView.builder(
//               itemCount: eve,
//               itemBuilder: (context, index) {
//                 return MyEventCard(event: event);
//               }),
//         ],
//       ),
//     );
//   }
// }
import 'package:ems_1/common/widgets/event_card.dart';
import 'package:ems_1/features/home/data/models/company_model.dart';
import 'package:ems_1/features/home/data/models/create_event_model.dart';
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:ems_1/features/home/presentation/cubit/my_event/my_event_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/my_event_card.dart';
import 'package:ems_1/features/home/presentation/screens/favorite/Fav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import BOTH card models and widgets
import 'package:ems_1/features/home/data/models/event_card_model.dart';
import 'package:provider/provider.dart';

class PopularEventsScreen extends StatelessWidget {
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
      price: 200,
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
      price: 200,
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
      price: 220,
      eventType: '',
    ),
  ];

  PopularEventsScreen({super.key});

  // This list contains only events from OTHER people, using EventCardModel
  final List<EventCardModel> otherOrganizersEvents = [
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
          companyName: 'S',
          companyImageUrl: 'companyImageUrl',
          discription: 'discription',
          location: 'location'),
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
          companyName: 'S',
          companyImageUrl: 'companyImageUrl',
          discription: 'discription',
          location: 'location'),
      organizerImage:
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=800',
      desc:
          'sdfEFKMfm[mef[mF[PMA{OF[APM[SPODVPSDLM[PSMLG[PSMFSP[MF[PSMF[PAM[PDFMA[DMA[PMLDA[MDLAMFDLMA[DMA[PLMDA[LMFA[PLMF[APLMSF[AMF]]]]]]]]]]]]]]]]]}]]]',
      price: 300,
      eventType: 'Training & Development 📚',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Popular Events'),
        ),
        body: BlocBuilder<MyEventCubit, MyEventState>(
            builder: (context, myEventsState) {
          // --- PREPARE THE LISTS ---

          // 1. Get ONLY the public events created by the user (these use EventModel)
          final List<CreateEventModel> myPublicEvents = myEventsState.myEvents
              .where((event) => event.privacy == EventPrivacy.public)
              .toList();

          // 2. COMBINE THE TWO LISTS INTO A DYNAMIC LIST
          // This list will contain a mix of `EventModel` objects and `EventCardModel` objects.
          final List<Object> allPopularEvents = [
            ...myPublicEvents, // Your public events come first
            ...otherOrganizersEvents // Then the events from other people
          ];

          if (allPopularEvents.isEmpty) {
            return const Center(child: Text("No popular events right now."));
          }

          // --- BUILD THE UI ---

          return Consumer<FavoritesProvider>(
            builder: (context, favProvider, child) {
              return ListView.builder(
                itemCount: allPopularEvents.length,
                itemBuilder: (context, index) {
                  final item = allPopularEvents[index];

                  if (item is CreateEventModel) {
                    return MyEventCard(
                      createEventModel: item,
                      onEdit: () {},
                      onDelete: () {},
                    );
                  } else if (item is EventCardModel) {
                    return EventCard(
                      eventCardModel: item,
                      onFavoriteToggle: (e) {
                        favProvider.toggleEvent(item);
                      },
                    );
                  }

                  return Container();
                },
              );
            },
          );
        }));
  }
}
