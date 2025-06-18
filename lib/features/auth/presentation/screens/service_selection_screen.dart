import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ems_1/features/auth/data/models/service_item_model.dart';
import 'package:ems_1/features/auth/presentation/cubit/service_selection_cubit/service_selection_cubit.dart';
import 'package:ems_1/features/auth/presentation/screens/register_screen.dart';
import 'package:ems_1/features/auth/presentation/screens/registration_type.dart';

final List<ServiceItemModel> providerServices = [
  ServiceItemModel(serviceName: 'Venue (place)', emoji: '🏛️'),
  ServiceItemModel(serviceName: 'Catering (food services)', emoji: '🍽️'),
  ServiceItemModel(serviceName: 'Beauty & Grooming', emoji: '💄'),
  ServiceItemModel(serviceName: 'Entertainment', emoji: '🎵'),
  ServiceItemModel(serviceName: 'Media & Photos', emoji: '📸'),
  ServiceItemModel(serviceName: 'Decoration', emoji: '🌸'),
  ServiceItemModel(serviceName: 'Gifts & Favors', emoji: '🎁'),
  ServiceItemModel(serviceName: 'Transportation', emoji: '🚗'),
  ServiceItemModel(serviceName: 'Fashion & Styling', emoji: '👗'),
  ServiceItemModel(serviceName: 'Security', emoji: '👮'),
];

final List<ServiceItemModel> companyServices = [
  ServiceItemModel(serviceName: 'Creative & Cultural', emoji: '🎨'),
  ServiceItemModel(serviceName: 'Social Celebrations', emoji: '🎉'),
  ServiceItemModel(serviceName: 'Music & Performance', emoji: '🎵'),
  ServiceItemModel(serviceName: 'Wellness & Lifestyle', emoji: '🧘'),
  ServiceItemModel(serviceName: 'Entertainment & Fun', emoji: '🎮'),
  ServiceItemModel(serviceName: 'Media & Content', emoji: '📺'),
  ServiceItemModel(serviceName: 'Educational & Academic', emoji: '🎓'),
  ServiceItemModel(serviceName: 'Training & Development', emoji: '📚'),
];

class ServiceSelectionScreen extends StatelessWidget {
  final RegistrationType registrationType;
  const ServiceSelectionScreen({required this.registrationType, super.key});

  @override
  Widget build(BuildContext context) {
    final servicesToShow = (registrationType == RegistrationType.provider)
        ? providerServices
        : companyServices;

    return BlocProvider(
      create: (context) => ServiceSelectionCubit(servicesToShow),
      child: ServiceSelectionView(registrationType: registrationType),
    );
  }
}

class ServiceSelectionView extends StatelessWidget {
  final RegistrationType registrationType;

  const ServiceSelectionView({required this.registrationType, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Choose Your Services', style: TextStyle(fontSize: 25)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ServiceSelectionCubit, ServiceSelectionState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: state.allServices.map((service) {
                        final bool isSelected =
                            state.selectedServices.contains(service);
                        return ServiceChip(
                          serviceItem: service,
                          isSelected: isSelected,
                          onTap: () {
                            context
                                .read<ServiceSelectionCubit>()
                                .toggleServiceSelection(service);
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF206173),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton.icon(
                icon: const Icon(Icons.arrow_circle_right, color: Colors.white),
                label: const Text(
                  'CONTINUE',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                onPressed: () {
                  final List<ServiceItemModel> selectedServices = context
                      .read<ServiceSelectionCubit>()
                      .state
                      .selectedServices;

                  if (selectedServices.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please choose at least one service')),
                    );
                    return;
                  }
                  // final List<ServiceItemModel> serviceNames = selectedServices
                  //     .map((service) => service.serviceName)
                  //     .toList();

                  // final  servicesString =
                  //     serviceNames.join(', ');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterScreen(
                        type: registrationType,
                        initialService: selectedServices,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Your ServiceChip widget is perfect and can stay here, or be moved to a common/widgets folder
class ServiceChip extends StatelessWidget {
  final ServiceItemModel serviceItem;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceChip({
    super.key,
    required this.serviceItem,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF206173) : const Color(0xFF94b1b4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              serviceItem.serviceName,
              style:
                  TextStyle(color: isSelected ? Colors.white : Colors.black87),
            ),
            const SizedBox(width: 8),
            Text(serviceItem.emoji, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
