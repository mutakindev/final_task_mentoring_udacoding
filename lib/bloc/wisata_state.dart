part of 'wisata_bloc.dart';

abstract class WisataState extends Equatable {
  const WisataState();
}

class WisataInitial extends WisataState {
  const WisataInitial();

  @override
  List<Object> get props => [];
}

class WisataLoading extends WisataState {
  const WisataLoading();

  @override
  List<Object> get props => [];
}

class WisataLoaded extends WisataState {
  final List<WisataResponse> listWisata;
  const WisataLoaded(this.listWisata);

  @override
  List<Object> get props => [listWisata];
}

class WisataError extends WisataState {
  const WisataError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
