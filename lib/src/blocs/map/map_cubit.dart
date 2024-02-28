import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:equatable/equatable.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  final MapController mapController = MapController();

  MapCubit({
    LatLng actualPosition = const LatLng(19.2740801, -99.7020265456915),
    bool isQrActive = false,
  }) : super(MapState(
          actualPosition: actualPosition,
          isQrActive: isQrActive,
        ));

  void changeActualPosition(LatLng newPosition) {
    mapController.move(newPosition, 18);
    emit(state.copyWith(actualPosition: newPosition));
  }

  void changeQrState() {
    emit(state.copyWith(isQrActive: !state.isQrActive));
  }
}
