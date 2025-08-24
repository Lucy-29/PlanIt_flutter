import 'package:flutter/material.dart';
import 'package:ems_1/features/home/data/models/selected_offer_model.dart';

// Renamed from SelectedProviderCard to SelectedOfferCard
class SelectedOfferCard extends StatelessWidget {
  final SelectedOfferModel offer; // <-- 1. It now takes a SelectedOfferModel
  final VoidCallback onRemove;

  const SelectedOfferCard({
    required this.offer, // <-- 2. Update constructor parameter name
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor, // Use cardColor for better theme adaptation
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          // This displays the PROVIDER's image
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(12),
          //   child: Image.network(
          //     offer.providerImageUrl, // <-- 3. Use the correct image URL field
          //     width: 50,
          //     height: 50,
          //     fit: BoxFit.cover,
          //     // Add error and loading builders for robustness
          //     loadingBuilder: (context, child, progress) => progress == null
          //         ? child
          //         : const Center(
          //             child: CircularProgressIndicator(strokeWidth: 2)),
          //     errorBuilder: (context, error, stackTrace) =>
          //         const Icon(Icons.business),
          //   ),
          // ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 4. DISPLAY THE OFFER'S DETAILS
                Text(
                  offer.offerName, // The specific offer name
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                // Text(
                //   "from ${offer.providerName}", // The provider who made the offer
                //   style: theme.textTheme.bodyMedium
                //       ?.copyWith(color: theme.hintColor),
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                // ),
                const SizedBox(height: 2),
                Text(
                  offer.offerPrice, // The price of the offer
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary, // Use a highlight color
                  ),
                ),
              ],
            ),
          ),
          // Remove Button remains the same
          IconButton(
            icon: const Icon(Icons.close_rounded, color: Colors.redAccent),
            onPressed: onRemove,
            tooltip: 'Remove Offer',
          ),
        ],
      ),
    );
  }
}
