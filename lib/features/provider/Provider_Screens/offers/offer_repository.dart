import 'package:ems_1/features/provider/Provider_Screens/offers/offers_model.dart';

abstract class OfferRepository {
  Future<List<Offer>> getOffers();
  Future<void> deleteOffer(String offerId);
  Future<void> addOffer(Offer newOffer);
}

class FakeOfferRepository implements OfferRepository {
  final List<Offer> _offers = [
    Offer(
      id: '1',
      title: 'a full set menu for dinner',
      price: 150000,
      imageUrl: 'https://i.ibb.co/bFq0mJ7/dinner-set.png',
      description: '',
    ),
    Offer(
      id: '2',
      title: 'a full set menu for 50 person',
      price: 7500000,
      imageUrl: 'https://i.ibb.co/3cbjMSf/pasta-set.png',
      description: '',
    ),
    Offer(
      id: '3',
      title: 'dessert set',
      price: 70000,
      imageUrl: 'https://i.ibb.co/gZ6xWd5/dessert-set.png',
      description: '',
    ),
  ];

  @override
  Future<List<Offer>> getOffers() async {
    await Future.delayed(const Duration(seconds: 1));
    return List<Offer>.from(_offers);
  }

  @override
  Future<void> deleteOffer(String offerId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _offers.removeWhere((offer) => offer.id == offerId);
    print('Offer with id $offerId deleted.');
  }

  @override
  Future<void> addOffer(Offer newOffer) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _offers.add(newOffer);
    print('Offer with id ${newOffer.id} added.');
  }
}
