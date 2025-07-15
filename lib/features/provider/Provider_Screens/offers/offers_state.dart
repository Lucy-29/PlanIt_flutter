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

class OfferCubit extends Cubit<OfferState> {
  final Dio dio;
  OfferCubit(this.dio) : super(OfferInitial());

  final String baseUrl = 'http://your-laravel-api.com/api';

  Future<void> fetchOffers() async {
    emit(OfferLoading());
    try {
      final response = await dio.get('$baseUrl/offers');
      final offers = (response.data as List)
          .map((offer) => Offer.fromJson(offer))
          .toList();
      emit(OfferLoaded(offers));
    } catch (e) {
      emit(OfferError('Failed to load offers'));
    }
  }

  Future<void> addOffer({
    required String description,
    required int price,
    required String imageUrl,
  }) async {
    try {
      final response = await dio.post('$baseUrl/offers', data: {
        'description': description,
        'price': price,
        'image_url': imageUrl,
      });
      if (state is OfferLoaded) {
        final currentOffers = (state as OfferLoaded).offers;
        final newOffer = Offer.fromJson(response.data);
        emit(OfferLoaded(List.from(currentOffers)..add(newOffer)));
      }
    } catch (e) {
      emit(OfferError('Failed to add offer'));
    }
  }

  Future<void> deleteOffer(int id) async {
    try {
      await dio.delete('$baseUrl/offers/$id');
      if (state is OfferLoaded) {
        final currentOffers = (state as OfferLoaded).offers;
        emit(OfferLoaded(currentOffers.where((o) => o.id != id).toList()));
      }
    } catch (e) {
      emit(OfferError('Failed to delete offer'));
    }
  }
}
