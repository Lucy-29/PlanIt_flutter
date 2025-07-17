import 'package:dio/dio.dart';
import 'package:ems_1/features/provider/Provider_Screens/offers/offers_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferLoaded extends OfferState {
  final List<Offer> offers;

  OfferLoaded(this.offers);
}

class OfferError extends OfferState {
  final String message;
  OfferError(this.message);
}
