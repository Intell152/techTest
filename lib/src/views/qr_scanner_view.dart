import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:minsait_tech_test/src/blocs/map/map_cubit.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

// Activate Qr to get LatLng Info
class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final MapCubit mapCubit = context.watch<MapCubit>();

    final Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: const Color(0xFF011B34), borderRadius: BorderRadius.circular(10)),
      width: size.width * 0.6,
      height: size.height * 0.4,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            width: size.width * 0.5,
            height: size.height * 0.23,
            child: MobileScanner(
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;

                for (var barcode in barcodes) {
                  final List<String> location = barcode.rawValue!.trim().split(',');
                  final double latitude = double.parse(location[0]);
                  final double longitude = double.parse(location[1]);

                  final LatLng newPosition = LatLng(latitude, longitude);
                  mapCubit.changeActualPosition(newPosition);
                }

                mapCubit.changeQrState();
              },
            ),
          ),
          Image.asset(
            'assets/images/qr_scan.png',
            width: size.width * 0.52,
          ),
          Align(
            alignment: const Alignment(1.11, -1.11),
            child: FloatingActionButton(
              materialTapTargetSize: MaterialTapTargetSize.padded,
              backgroundColor: const Color(0xFF204c94),
              shape: const CircleBorder(),
              child: const Icon(Icons.close, color: Colors.white),
              onPressed: () => mapCubit.changeQrState(),
            ),
          )
        ],
      ),
    );
  }
}
