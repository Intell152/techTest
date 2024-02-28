import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart' as map;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:minsait_tech_test/src/blocs/map/map_cubit.dart';
import 'package:minsait_tech_test/src/widgets/widgets.dart';
import 'package:minsait_tech_test/src/views/views.dart';

// view that shows the MapBox map with 3 different locations and a button that activates the QR reader.
class MapView extends StatelessWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapCubit mapCubit = context.watch<MapCubit>();

    final Size size = MediaQuery.of(context).size;

    return ModalProgressHUD(
      inAsyncCall:
          mapCubit.state.isQrActive,
      opacity: 0.50,
      progressIndicator: const QrScannerView(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.25,
            child: const _ButtonsPanel(),
          ),
          SizedBox(
            width: double.infinity,
            height: size.height * 0.55,
            child: _MapField(position: mapCubit.state.actualPosition),
          ),
        ],
      ),
    );
  }
}

// Show Action Buttons
class _ButtonsPanel extends StatelessWidget {
  const _ButtonsPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapCubit mapCubit = context.watch<MapCubit>();

    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomFilledButton(
                title: AppLocalizations.of(context)!.museum,
                onPressed: () => mapCubit.changeActualPosition(
                    const LatLng(19.2740801, -99.7020265456915)),
              ),
            ),
            Expanded(
              child: CustomFilledButton(
                title: AppLocalizations.of(context)!.soumaya,
                onPressed: () => mapCubit
                    .changeActualPosition(const LatLng(19.4352, -99.1412)),
              ),
            ),
            Expanded(
              child: CustomFilledButton(
                title: AppLocalizations.of(context)!.bartes,
                onPressed: () => mapCubit.changeActualPosition(
                    const LatLng(19.4407, -99.2047)),
              ),
            ),
          ],
        ),
        CustomFilledButton(
          title: AppLocalizations.of(context)!.qr,
          onPressed: () => mapCubit.changeQrState(),
        ),
        Center(
          child: Text(AppLocalizations.of(context)!.qrinfo,
              style: Theme.of(context).textTheme.bodySmall),
        )
      ],
    );
  }
}

//  Map Space
class _MapField extends StatelessWidget {
  //  Posición del marcador en el mapa
  final LatLng position;

  const _MapField({
    required this.position,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MapCubit mapCubit = context.watch<MapCubit>();

    return map.FlutterMap(
      options: const map.MapOptions(
        initialCenter: LatLng(19.2740801, -99.7020265456915),
        minZoom: 5,
        maxZoom: 25,
        initialZoom: 18,
      ),
      mapController: mapCubit.mapController,
      children: [
        map.TileLayer(
          urlTemplate: dotenv.env['MAPURLTEMPLATE'],
          userAgentPackageName: dotenv.env['USERAGENT']!,
        ),
        map.MarkerLayer(
          markers: [
            map.Marker(
              point: position,
              width: 50,
              height: 50,
              child: Icon(
                Icons.location_on,
                color: Colors.red[900],
              ),
            ),
          ],
        )
      ],
    );
  }
}
