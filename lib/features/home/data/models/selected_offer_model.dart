import 'package:equatable/equatable.dart';

// An enum to represent the status of the provider's response
enum OfferStatus { pending, approved, rejected }

class SelectedOfferModel extends Equatable {
  // Details about the specific OFFER
  final String offerId;
  final String offerName;
  // Let's add price here since it's crucial for an offer
  final String offerPrice;

  // Details about the PROVIDER offering the service
  final String providerId;
  final String providerName;
  final String providerImageUrl;

  // The current status of this selection
  final OfferStatus status;

  const SelectedOfferModel({
    required this.offerId,
    required this.offerName,
    required this.offerPrice,
    required this.providerId,
    required this.providerName,
    required this.providerImageUrl,
    this.status = OfferStatus.pending,
  });

  @override
  // Use IDs for equatable comparison as they are unique
  List<Object?> get props => [offerId, providerId];
}
