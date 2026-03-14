import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../domain/entities/gym_entity.dart';

/// A polished card that represents a single gym in the feed.
///
/// Uses a [Hero] animation keyed on [AppConstants.heroTagPrefix] + [gym.id]
/// so the gym thumbnail morphs into the detail page banner.
class GymCard extends StatelessWidget {
  const GymCard({
    super.key,
    required this.gym,
    required this.isSaved,
    required this.onTap,
    required this.onSaveToggle,
  });

  final GymEntity gym;
  final bool isSaved;
  final VoidCallback onTap;
  final VoidCallback onSaveToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final districtColor = _districtColor(gym.district);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail with Hero animation ───────────────────────────────
            Hero(
              tag: '${AppConstants.heroTagPrefix}${gym.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: gym.thumbnailUrl != null
                      ? CachedNetworkImage(
                          imageUrl: gym.thumbnailUrl!,
                          fit: BoxFit.cover,
                          placeholder: (ctx, url) => Container(
                            color: AppColors.primary.withAlpha(30),
                            child: const Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          errorWidget: (ctx, url, err) => _PlaceholderImage(),
                        )
                      : _PlaceholderImage(),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Name + Bookmark ──────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          gym.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isSaved ? Icons.bookmark : Icons.bookmark_border,
                          color: isSaved ? AppColors.accent : null,
                        ),
                        tooltip: isSaved ? 'Unsave gym' : 'Save gym',
                        onPressed: onSaveToggle,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // ── District chip + Price ────────────────────────────────
                  Row(
                    children: [
                      _DistrictChip(
                          district: gym.district, color: districtColor),
                      const Spacer(),
                      _PriceTag(price: gym.subscriptionPrice),
                    ],
                  ),

                  // ── Amenity preview ──────────────────────────────────────
                  if (gym.amenities.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 2,
                      children: gym.amenities.take(3).map((a) {
                        return Chip(
                          label: Text(a),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          visualDensity: VisualDensity.compact,
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _districtColor(String district) {
    switch (district) {
      case 'Gasabo':
        return AppColors.gasaboChip;
      case 'Kicukiro':
        return AppColors.kicukiroChip;
      case 'Nyarugenge':
        return AppColors.nyarugengeChip;
      default:
        return AppColors.primary;
    }
  }
}

class _PlaceholderImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary.withAlpha(20),
      child: const Center(
        child:
            Icon(Icons.fitness_center, size: 48, color: AppColors.primary),
      ),
    );
  }
}

class _DistrictChip extends StatelessWidget {
  const _DistrictChip({required this.district, required this.color});
  final String district;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(80)),
      ),
      child: Text(
        district,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  const _PriceTag({required this.price});
  final double price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'RWF ${price.toStringAsFixed(0)}',
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const TextSpan(
            text: '/mo',
            style: TextStyle(
              color: AppColors.subtitleLight,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
