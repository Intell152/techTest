part of 'map_cubit.dart';

class MapState extends Equatable {
  final LatLng actualPosition;
  final bool isQrActive;

  const MapState({
    required this.actualPosition,
    required this.isQrActive,
  });

  MapState copyWith({
    LatLng? actualPosition,
    bool? isQrActive,
  }) =>
      MapState(
        actualPosition: actualPosition ?? this.actualPosition,
        isQrActive: isQrActive ?? this.isQrActive,
      );

  @override
  List<Object> get props => [actualPosition, isQrActive];
}
