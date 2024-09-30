import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/BuyvehiclesModels/BuyNearVehiclesModel.dart';

part 'buy_near_vehicles_event.dart';
part 'buy_near_vehicles_state.dart';

class BuyNearVehiclesBloc extends Bloc<BuyNearVehiclesEvent, BuyNearVehiclesState> {
  late List<BuyNearVehiclesModel>  buynearvehicles;
  UserApi userApi =UserApi();
  BuyNearVehiclesBloc() : super(BuyNearVehiclesInitial()) {
    on<FeatchBuyNearVehicles>((event, emit) async{
      emit(BuyNearVehiclesBlocLoading() );
      try{ buynearvehicles = await userApi.getBuyNearVehicles(event.lat, event.long);
      emit(BuyNearVehiclesBlocLoaded());
      }
          catch(e){
       emit(BuyNearVehiclesBlocError()) ;
          }


    });
  }
}
