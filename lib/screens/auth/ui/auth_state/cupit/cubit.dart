import 'package:bloc/bloc.dart';
import 'package:carwash/screens/auth/ui/auth_state/cupit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubite extends Cubit<UserType>{

  UserCubite():super (UserInitialStates());
  static UserCubite get(context) => BlocProvider.of(context);
  bool admin=false;
  bool Gargeowner=false;
  bool tUser=false;

  void isAdmin(bool admin) {
    this. admin = admin;
    emit(AdminState());
  }
  void isTUser(bool user) {
    this.tUser = user;
    emit(TradinalUser());
  }
   isGarageOwner(String garage) {
    if(garage =='Garage Owner')
     this.Gargeowner = true;
    else if(garage =='tradetional User')
      this.Gargeowner=false;
    emit(GarageUser());
  }
}