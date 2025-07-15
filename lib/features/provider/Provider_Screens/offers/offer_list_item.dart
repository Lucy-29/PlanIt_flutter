import 'package:ems_1/features/provider/Provider_Screens/offers/offers_model.dart';
import 'package:flutter/material.dart';

class OfferListItem extends StatelessWidget {
  final Offer offer;
  final VoidCallback onDelete;

  const OfferListItem({
    super.key,
    required this.offer,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // استخدام لون الكارت من الثيم الحالي
      color: Color(0xFFf9f9f6),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            // Offer Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                offer.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                // إظهار مؤشر تحميل أثناء جلب الصورة
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 100,
                    height: 80,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                // إظهار أيقونة خطأ في حال فشل تحميل الصورة
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image, color: Colors.grey[400]),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Offer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Text(
                      '${offer.price.toInt()} S.P',
                      style: TextStyle(
                        color: Colors.green.shade600, // لون السعر
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Delete Icon
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFf0dddb),
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.delete_outlined,
                  color: Color(0XFFd77474),
                ),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
