import 'package:flutter/material.dart';
import 'package:gaslow_app/locator.dart';
import 'package:gaslow_app/models/GasStation.dart';
import 'package:gaslow_app/models/MyLocation.dart';
import 'package:gaslow_app/services/StationService.dart';
import 'package:gaslow_app/widgets/StationTile.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class StationsList extends StatefulWidget {
  final List<GasStation> stations;
  final bool isLoading;
  final MyLocation? fromLocation;
  final GasStation? selectedStation;

  final IntCallback onStationTap;
  final IntCallback? onStationShare;
  final FavoriteCallback onFavoriteChange;
  final Set<int> favoriteStationIds;

  StationsList({
    required this.stations,
    required this.isLoading,
    required this.onStationTap,
    required this.selectedStation,
    this.fromLocation,
    this.onStationShare,
    required this.onFavoriteChange,
    required this.favoriteStationIds,
  });

  @override
  State<StatefulWidget> createState() => _StationsListState();
}

class _StationsListState extends State<StationsList> {
  AutoScrollController? controller;
  final scrollDirection = Axis.vertical;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    final selectedIndex = widget.selectedStation != null
        ? widget.stations.indexOf(widget.selectedStation!)
        : -1;
    if (selectedIndex != -1) {
      controller?.scrollToIndex(
        selectedIndex,
        preferPosition: AutoScrollPosition.begin,
      );
    }

    return ListView.builder(
        shrinkWrap: false,
        scrollDirection: scrollDirection,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        controller: controller,
        itemCount: widget.stations.length,
        itemBuilder: (context, index) {
          final station = widget.stations[index];
          return _wrapScrollTag(
              index: index,
              child: StationTile(
                onStationTap: widget.onStationTap,
                station: station,
                onMapTap: () => getIt<StationService>().openMap(station),
                fromLocation: widget.fromLocation,
                onShareTap: widget.onStationShare,
                isFavorite: widget.favoriteStationIds.contains(station.id),
                onFavoriteChange: widget.onFavoriteChange,
              ));
        });
  }

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller!,
        index: index,
        child: child,
        highlightColor: Colors.black.withValues(alpha: 0.1),
      );
}
