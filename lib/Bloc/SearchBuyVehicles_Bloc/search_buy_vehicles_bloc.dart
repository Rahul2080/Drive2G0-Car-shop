import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/BuyvehiclesModels/SearchBuyVehiclesModel.dart';

part 'search_buy_vehicles_event.dart';
part 'search_buy_vehicles_state.dart';

class SearchBuyVehiclesBloc extends Bloc<SearchBuyVehiclesEvent, SearchBuyVehiclesState> {
  late List<SearchBuyVehiclesModel> searchbuyvehicles;
  UserApi userApi =UserApi();

  SearchBuyVehiclesBloc() : super(SearchBuyVehiclesInitial()) {
    on<FeatchSearchBuyVehicles>((event, emit) async{
emit(SearchBuyVehiclesBlocLoading());
try{ searchbuyvehicles = await userApi.getSearchBuyVehicles(event.brandname);
emit( SearchBuyVehiclesBlocLoaded());
}
    catch(e){ emit(SearchBuyVehiclesBlocError());}

    });
  }
}
