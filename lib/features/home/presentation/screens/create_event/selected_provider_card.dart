import 'package:flutter/material.dart';
import 'package:ems_1/features/home/data/models/selected_provider_model.dart';

class SelectedProviderCard extends StatelessWidget {
  final SelectedProviderModel provider;
  final VoidCallback onRemove;

  const SelectedProviderCard({
    required this.provider,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              provider.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(provider.jobTitle, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          // Remove Button
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: onRemove,
            tooltip: 'Remove Provider',
          ),
        ],
      ),
    );
  }
}
