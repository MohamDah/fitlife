import 'package:equatable/equatable.dart';

/// Domain-level gym entity. Implemented by Person 3 (Gym Feed & Detail).
class GymEntity extends Equatable {
  const GymEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.district,
    required this.subscriptionPrice,
    required this.amenities,
    this.thumbnailUrl,
    this.galleryUrls = const [],
  });

  final String id;
  final String name;
  final String description;
  final String district;
  final double subscriptionPrice;
  final List<String> amenities;
  final String? thumbnailUrl;
  final List<String> galleryUrls;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        district,
        subscriptionPrice,
        amenities,
        thumbnailUrl,
        galleryUrls,
      ];
}
