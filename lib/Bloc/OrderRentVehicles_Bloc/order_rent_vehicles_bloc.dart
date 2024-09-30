import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/ModelClass/RentVehiclesModels/OrderRentVehicleModel.dart';
import 'package:meta/meta.dart';

import '../../Repository/Api/api.dart';

part 'order_rent_vehicles_event.dart';

part 'order_rent_vehicles_state.dart';

class OrderRentVehiclesBloc
    extends Bloc<OrderRentVehiclesEvent, OrderRentVehiclesState> {
  OrderRentVehiclesBloc() : super(OrderRentVehiclesInitial()) {
    late OrderRentVehicleModel orderRentVehicleModel;
    UserApi userApi = UserApi();
    on<FeatchOrderRentVehicles>((event, emit) async {
      emit(OrderRentVehiclesBlocLoading());
      try {
        orderRentVehicleModel = await userApi.getOrderRentVehicles(
            event.vehicleid,
            event.pickeddate,
            event.returneddate,
            event.pickuplocationcontroller,
            event.returnlocationcontroller,
            event.amount);
        emit(OrderRentVehiclesBlocLoaded());
      } catch (e) { emit( OrderRentVehiclesBlocError());}
    });
  }
}
