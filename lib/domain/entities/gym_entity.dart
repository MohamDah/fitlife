import 'package:equatable/equatable.dart';

/// Pure-Dart representation of a gym.
enum GymStatus { pending, approved, rejected }

/// Domain-level gym entity. Implemented by Person 3 (Gym Feed &amp; Detail).
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
    this.status = GymStatus.pending,
  });

  final String id;
  final String name;
  final String description;
  final String district;
  final double subscriptionPrice;
  final List<String> amenities;
  final String? thumbnailUrl;
  final List<String> galleryUrls;
  final GymStatus status;

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
    status,
  ];
}
