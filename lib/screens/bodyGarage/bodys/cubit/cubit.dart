import 'package:bloc/bloc.dart';
import 'package:carwash/screens/bodyGarage/bodys/cubit/stats.dart';
import 'package:carwash/screens/bodyGarage/bodys/models/home_screen.dart';
import 'package:carwash/screens/bodyGarage/bodys/models/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GarageCubit extends Cubit<GarageSates> {
  GarageCubit() : super(NewsInitialStates());

  static GarageCubit get(context) => BlocProvider.of(context);
  int curentIndex = 0;
  bool admin = true;
  bool bloked = false;
  List title = ['Home', 'Notification'];
  List screensGarageOwner = [HomeScreenGarage(), NotificationScreenOFGarage()];
  List<BottomNavigationBarItem> garageTap = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          size: 30,
        ),
        label: ''),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.notification_important,
          size: 30,
        ),
        label: ''),
  ];

  void changeScreen(int index) {
    curentIndex = index;
    emit(NewsBottomNaveStates());
  }

  void isAdmin(bool admin) {
    this.admin = admin;
    emit(AdminState());
  }

  void isBlocked(bool bloked) {
    this.bloked = bloked;
    emit(UserBlocked());
  }
}
