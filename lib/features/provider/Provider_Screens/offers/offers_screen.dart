// import 'package:dio/dio.dart';
// import 'package:ems_1/features/provider/Provider_Screens/offers/offers_state.dart';
// import 'package:ems_1/features/provider/offers_cubit/offers_cubit.dart';
// import 'package:ems_1/features/provider/offers_cubit/offers_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class OffersScreen extends StatefulWidget {
//   @override
//   State<OffersScreen> createState() => _OffersScreenState();
// }

// class _OffersScreenState extends State<OffersScreen> {
//   final TextEditingController _descController = TextEditingController();
//   final TextEditingController _priceController = TextEditingController();
//   final TextEditingController _imageUrlController = TextEditingController();

//   void _showAddOfferDialog(BuildContext context) {
//     _descController.clear();
//     _priceController.clear();
//     _imageUrlController.clear();

//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('ADD OFFER'),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: _descController,
//                 decoration: InputDecoration(
//                   hintText: 'Offer Description...',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _priceController,
//                 decoration: InputDecoration(
//                   hintText: 'Offer Price...',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: _imageUrlController,
//                 decoration: InputDecoration(
//                   hintText: 'Offer Image URL...',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final desc = _descController.text.trim();
//               final price = int.tryParse(_priceController.text.trim()) ?? 0;
//               final imageUrl = _imageUrlController.text.trim();

//               if (desc.isEmpty || price <= 0 || imageUrl.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Please fill all fields validly')),
//                 );
//                 return;
//               }

//               context.read<OfferCubit>().addOffer(
//                     description: desc,
//                     price: price,
//                     imageUrl: imageUrl,
//                   );

//               Navigator.of(context).pop();
//             },
//             child: Text('Add'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     // context.read<OfferCubit>().fetchOffers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => OfferCubit(Dio())..fetchOffers(),
//       child: Scaffold(
//         appBar: AppBar(title: Text('your offers')),
//         body: BlocBuilder<OfferCubit, OfferState>(
//           builder: (context, state) {
//             if (state is OfferLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is OfferLoaded) {
//               return ListView.builder(
//                 itemCount: state.offers.length,
//                 itemBuilder: (context, index) {
//                   final offer = state.offers[index];
//                   return ListTile(
//                     leading: Image.network(offer.imageUrl,
//                         width: 60, height: 60, fit: BoxFit.cover),
//                     title: Text(offer.description),
//                     subtitle: Text('${offer.price} S.P'),
//                     trailing: IconButton(
//                       icon: Icon(Icons.delete),
//                       onPressed: () =>
//                           context.read<OfferCubit>().deleteOffer(offer.id),
//                     ),
//                   );
//                 },
//               );
//             } else if (state is OfferError) {
//               return Center(child: Text(state.message));
//             } else {
//               return Container();
//             }
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => _showAddOfferDialog(context),
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }
import 'package:ems_1/features/provider/offers_cubit/offers_cubit.dart';
import 'package:ems_1/features/provider/offers_cubit/offers_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'offers_cubit.dart';
import 'offers_state.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _showAddOfferDialog(BuildContext context) {
    _descController.clear();
    _priceController.clear();
    _imageUrlController.clear();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('ADD OFFER'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  hintText: 'Offer Description...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  hintText: 'Offer Price...',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  hintText: 'Offer Image URL...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final desc = _descController.text.trim();
              final price = int.tryParse(_priceController.text.trim()) ?? 0;
              final imageUrl = _imageUrlController.text.trim();

              if (desc.isEmpty || price <= 0 || imageUrl.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Please fill all fields validly')),
                );
                return;
              }

              context.read<OfferCubit>().addOffer(
                    description: desc,
                    price: price,
                    imageUrl: imageUrl,
                  );

              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Offers')),
      body: BlocBuilder<OfferCubit, OfferState>(
        builder: (context, state) {
          if (state is OfferLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OfferLoaded) {
            return ListView.builder(
              itemCount: state.offers.length,
              itemBuilder: (context, index) {
                final offer = state.offers[index];
                return ListTile(
                  leading: Image.network(
                    offer.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(offer.description),
                  subtitle: Text('${offer.price} S.P'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () =>
                        context.read<OfferCubit>().deleteOffer(offer.id),
                  ),
                );
              },
            );
          } else if (state is OfferError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddOfferDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
