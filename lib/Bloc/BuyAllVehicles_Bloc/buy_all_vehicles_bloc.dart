import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/BuyvehiclesModels/BuyAllVehiclesModel.dart';

part 'buy_all_vehicles_event.dart';
part 'buy_all_vehicles_state.dart';

class BuyAllVehiclesBloc extends Bloc<BuyAllVehiclesEvent, BuyAllVehiclesState> {

  late  List<BuyAllVehiclesModel> buyallvehicles;
  UserApi userApi = UserApi();
  BuyAllVehiclesBloc() : super(BuyAllVehiclesInitial()) {
    on<FeatchBuyAllVehicle>((event, emit) async{

      emit(BuyAllVehiclesBlocLoading());
      try{ buyallvehicles = await userApi.getBuyAllVehicles();
      emit(BuyAllVehiclesBlocLoaded());
      }
          catch(e){emit(BuyAllVehiclesBlocError());}


    });
  }
}
