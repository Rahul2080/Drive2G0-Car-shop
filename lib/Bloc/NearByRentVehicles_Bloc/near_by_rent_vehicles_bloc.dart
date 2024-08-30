import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repository/Api/api.dart';
import '../../Repository/ModelClass/NearByRentVehiclesModel.dart';

part 'near_by_rent_vehicles_event.dart';

part 'near_by_rent_vehicles_state.dart';

class NearByRentVehiclesBloc
    extends Bloc<NearByRentVehiclesEvent, NearByRentVehiclesState> {
  late List<NearByRentVehiclesModel> nearbyrentvechicles;
  UserApi userApi = UserApi();

  NearByRentVehiclesBloc() : super(NearByRentVehiclesInitial()) {
    on<FeatchNearByCarVehicles>((event, emit) async {
      emit(NearByRentVehiclesBlocLoading());
      try {
        nearbyrentvechicles =
            await userApi.getNearRentVehicles(event.lat, event.long);
        emit(NearByRentVehiclesBlocLoaded());
      } catch (e) {
        print(e.toString());
        emit(NearByRentVehiclesBlocError());
      }
    });
  }
}
