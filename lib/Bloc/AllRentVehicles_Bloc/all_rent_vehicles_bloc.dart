import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Repository/Api/api.dart';
import '../../Repository/ModelClass/AllRentVehiclesModel.dart';

part 'all_rent_vehicles_event.dart';
part 'all_rent_vehicles_state.dart';

class AllRentVehiclesBloc extends Bloc<AllRentVehiclesEvent, AllRentVehiclesState> {
late List<AllRentVehiclesModel>  allrentvehicles;
UserApi userApi = UserApi();
  AllRentVehiclesBloc() : super(AllRentVehiclesInitial()) {
    on<AllRentVehiclesEvent>((event, emit) async{
      emit (AllRentVehiclesBlocLoading());
      try{ allrentvehicles=await userApi.getAllRentVehicles();
      emit(AllRentVehiclesBlocLoaded() );

      }
          catch(e){emit (AllRentVehiclesBlocError());}



    });
  }
}
