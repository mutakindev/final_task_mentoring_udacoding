part of 'wisata_bloc.dart';

abstract class WisataEvent extends Equatable {
  const WisataEvent();
}

class GetWisataList extends WisataEvent {
  @override
  List<Object> get props => [];
}
