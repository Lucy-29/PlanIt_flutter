import 'package:dio/dio.dart';
import 'package:ems_1/features/provider/offers_cubit/offers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'offers_screen.dart';
import 'offers_cubit.dart';

class OffersScreenWrapper extends StatelessWidget {
  const OffersScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OfferCubit(Dio())..fetchOffers(),
      child: OffersScreen(),
    );
  }
}
