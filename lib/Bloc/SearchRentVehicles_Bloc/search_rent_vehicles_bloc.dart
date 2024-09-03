import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/SearchRentVehiclesModel.dart';

part 'search_rent_vehicles_event.dart';
part 'search_rent_vehicles_state.dart';

class SearchRentVehiclesBloc extends Bloc<SearchRentVehiclesEvent, SearchRentVehiclesState> {
  late List<SearchRentVehiclesModel> searchrentvehicles;
  UserApi userApi =UserApi();
  SearchRentVehiclesBloc() : super(SearchRentVehiclesInitial()) {
    on<FeatchSearchRentVehicles>((event, emit) async{
      emit( SearchRentVehiclesBlocLoading());
      try{ searchrentvehicles=await userApi.getSearchRentVehicles(event.brandname);
      emit( SearchRentVehiclesBlocLoaded());
      }
          catch(e){ emit ( SearchRentVehiclesBlocError());}


    });
  }
}
