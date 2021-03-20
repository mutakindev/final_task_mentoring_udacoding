import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parawisata_mutakin/model/wisata_model.dart';
import 'package:parawisata_mutakin/network/services.dart';

part 'wisata_event.dart';
part 'wisata_state.dart';

class WisataBloc extends Bloc<WisataEvent, WisataState> {
  WisataBloc() : super(WisataInitial());

  final ApiServices apiServices = ApiServices();

  @override
  Stream<WisataState> mapEventToState(
    WisataEvent event,
  ) async* {
    if (event is GetWisataList) {
      try {
        yield WisataLoading();
        final mList = await apiServices.getDataWisata();
        yield WisataLoaded(mList);
      } catch (e) {
        yield WisataError(e.toString());
      }
    }
  }
}
