import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/BuyvehiclesModels/OrderBuyVehiclesModel.dart';

part 'order_buy_event.dart';

part 'order_buy_state.dart';

class OrderBuyBloc extends Bloc<OrderBuyEvent, OrderBuyState> {
  late OrderBuyVehiclesModel orderBuyVehiclesModel;
  UserApi userApi = UserApi();

  OrderBuyBloc() : super(OrderBuyInitial()) {
    on<FeatchOrderBuyVehicles>((event, emit) async {
      emit(OrderBuyVehiclesBlocLoading());
      try {
        orderBuyVehiclesModel = await userApi.getOrderBuyVehicles(
            event.vehicleid,
            event.buyername,
            event.buyerphonenumber,
            event.buyeremail,
            event.buyeraddress,
            event.amount);
        emit(OrderBuyVehiclesBlocLoaded());
      }
      catch (e) { emit (OrderBuyVehiclesBlocError());
      }
    });
  }
}
