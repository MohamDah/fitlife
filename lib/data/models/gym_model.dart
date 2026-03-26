import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/gym_entity.dart';

/// Firestore-aware model that extends the domain [GymEntity].
class GymModel extends GymEntity {
  const GymModel({
    required super.id,
    required super.name,
    required super.description,
    required super.district,
    required super.subscriptionPrice,
    required super.amenities,
    super.thumbnailUrl,
    super.galleryUrls,
    super.status,
  });

  factory GymModel.fromFirestore({
    required DocumentSnapshot<Map<String, dynamic>> snapshot,
  }) {
    final data = snapshot.data()!;
    return GymModel(
      id: snapshot.id,
      name: data['name'] as String,
      description: data['description'] as String,
      district: data['district'] as String,
      subscriptionPrice: (data['subscriptionPrice'] as num).toDouble(),
      amenities: List<String>.from(data['amenities'] ?? []),
      thumbnailUrl: data['thumbnailUrl'],
      galleryUrls: List<String>.from(data['galleryUrls'] ?? []),
      status: GymStatus.values.byName(data['status'] ?? 'pending'),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'district': district,
      'subscriptionPrice': subscriptionPrice,
      'amenities': amenities,
      'thumbnailUrl': thumbnailUrl,
      'galleryUrls': galleryUrls,
      'status': status.name,
    };
  }
}
