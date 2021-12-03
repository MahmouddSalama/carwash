
import 'package:bloc/bloc.dart';
import 'package:carwash/screens/bodyGarage/bodys/cubit/stats.dart';
import 'package:carwash/screens/user_body/bodys/cubit/state.dart';
import 'package:carwash/screens/user_body/bodys/modules/user_home.dart';
import 'package:carwash/screens/user_body/bodys/modules/user_orers.dart';
import 'package:carwash/screens/user_body/bodys/screens/user_orders/user_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(InitialStates());

  static UserCubit get(context) => BlocProvider.of(context);
  int curentIndex = 0;
  bool admin=true;
  bool bloked=false;
  List title=[
    'Home',
    'Orders'
  ];
  List screensUser=[
    UserHome(),
    UserOrders(),
  ];
  List<BottomNavigationBarItem> userTap=[
    BottomNavigationBarItem(icon:Icon(Icons.home,size: 30,) ,label: ''),
    BottomNavigationBarItem(icon:Icon(Icons.bookmark_border,size: 30,) ,label: ''),
  ];

  void changeScreen(int index) {
    curentIndex = index;
    emit(BottomNaveStates());
  }
}
