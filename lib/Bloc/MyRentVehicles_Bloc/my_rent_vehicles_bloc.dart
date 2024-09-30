import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/RentVehiclesModels/MyRentVehiclesModel.dart';

part 'my_rent_vehicles_event.dart';
part 'my_rent_vehicles_state.dart';

class MyRentVehiclesBloc extends Bloc<MyRentVehiclesEvent, MyRentVehiclesState> {
  late List<MyRentVehiclesModel> myrentvehicles;
  UserApi userApi=UserApi();
  MyRentVehiclesBloc() : super(MyRentVehiclesInitial()) {
    on<FeatchMyRentVehicles>((event, emit) async{

      emit( MyRentVehiclesBlocLoading());
      try{ myrentvehicles=await userApi.getMyRentVehicles() ;

      emit( MyRentVehiclesBlocLoaded());
      }
          catch(e){
        print(e.toString());
        emit( MyRentVehiclesBlocError()); }
    });
  }
}
