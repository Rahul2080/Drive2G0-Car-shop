import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';
import '../../Repository/ModelClass/BuyvehiclesModels/MyOrderBuyVehiclesModel.dart';
part 'my_order_buy_vehicles_event.dart';
part 'my_order_buy_vehicles_state.dart';

class MyOrderBuyVehiclesBloc
    extends Bloc<MyOrderBuyVehiclesEvent, MyOrderBuyVehiclesState> {
  late List<MyOrderBuyVehiclesModel> myorderbuyvehicles;
  UserApi userApi = UserApi();
  MyOrderBuyVehiclesBloc() : super(MyOrderBuyVehiclesInitial()) {
    on<FeatchMyOrderBuyVehicles>((event, emit) async {
      emit(MyOrderBuyVehiclesBlocLoading());
      try {
        myorderbuyvehicles = await userApi.getMyOrderBuyVehicles();
        emit(MyOrderBuyVehiclesBlocLoaded());
      } catch (e) { emit( MyOrderBuyVehiclesBlocError());}
    });
  }
}
