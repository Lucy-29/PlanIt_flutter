// import 'package:ems_1/features/home/data/models/service_card_model.dart';
// import 'package:flutter/material.dart';

// class ServiceDetailsScreen extends StatelessWidget {
//   final ServiceCardModel serviceCardModel;

//   const ServiceDetailsScreen({super.key, required this.serviceCardModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Image.network(
//                 serviceCardModel.placeImageUrl,
//                 height: 350,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       serviceCardModel.serviceName,
//                       style: const TextStyle(
//                           fontSize: 30, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_on),
//                         const SizedBox(width: 10),
//                         Text(serviceCardModel.location,
//                             style: const TextStyle(fontSize: 20)),
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             CircleAvatar(
//                               radius: 20,
//                               backgroundImage: NetworkImage(
//                                   serviceCardModel.providerImageUrl),
//                             ),
//                             const SizedBox(width: 10),
//                             Text(
//                               serviceCardModel.providerName,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ],
//                         ),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                           ),
//                           child: Text('Visit'),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 15),
//                     Text(serviceCardModel.description),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 40,
//             left: 10,
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(Icons.arrow_back,
//                       color: Colors.white, size: 30),
//                 ),
//                 const SizedBox(width: 16),
//                 const Text(
//                   'Service Details',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 40,
//             left: 60,
//             child: ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 fixedSize: Size(280, 55),
//                 backgroundColor: Color(0xFF50C878),
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 16.0),
//                     child: Text(
//                       'Book Now',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     width: 35,
//                     height: 35,
//                     margin: EdgeInsets.only(right: 8),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF1a5f33),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.arrow_forward,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
