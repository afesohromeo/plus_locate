import 'package:flutter_test/flutter_test.dart';
import 'package:plus_locate/plus_locate.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('detail card stays expanded when a new location is selected', () async {
    final bloc = MapViewBloc(
      geocodingRepository: GeocodingRepository(),
      plusCodeRepository: PlusCodeRepository(),
    );

    // Subscribe before adding events: the state stream doesn't replay.
    final reachedNewLocation = expectLater(
      bloc.stream,
      emitsThrough(
        predicate<MapViewState>(
          (s) =>
              s.geocodeStatus == GenericStatus.success &&
              s.currentLatitude == 3.86,
        ),
      ),
    );

    bloc
      ..add(const MapViewEvent.setDetailCardExpanded(expanded: true))
      ..add(const MapViewEvent.focusOnLocation(latitude: 4.05, longitude: 9.76))
      // No native geocoder in tests: the address lookup fails, which the
      // bloc treats as non-fatal.
      ..add(const MapViewEvent.reverseGeocodeLocation(
        latitude: 3.86,
        longitude: 11.52,
      ));

    await reachedNewLocation;
    expect(bloc.state.isDetailCardExpanded, isTrue);
    await bloc.close();
  });
}
