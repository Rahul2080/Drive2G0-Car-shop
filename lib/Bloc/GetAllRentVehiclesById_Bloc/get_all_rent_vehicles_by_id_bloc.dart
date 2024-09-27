import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/GetAllRentVehiclesByIDModel.dart';
import 'package:meta/meta.dart';

part 'get_all_rent_vehicles_by_id_event.dart';

part 'get_all_rent_vehicles_by_id_state.dart';

class GetAllRentVehiclesByIdBloc
    extends Bloc<GetAllRentVehiclesByIdEvent, GetAllRentVehiclesByIdState> {
  late GetAllRentVehiclesByIdModel getAllRentVehiclesByIdModel;
  UserApi userApi = UserApi();
  GetAllRentVehiclesByIdBloc() : super(GetAllRentVehiclesByIdInitial()) {
    on<FeatchGetAllRentVehiclesById>((event, emit) async{
      emit(GetAllRentVehiclesByIdBlocLoading() );
      try{
        getAllRentVehiclesByIdModel=await userApi.getGetAllRentVehiclesById(event.vehicleId);
        emit(GetAllRentVehiclesByIdBlocLoaded());


      }
          catch(e){emit(GetAllRentVehiclesByIdBlocError());}


    });
  }
}
