import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  

}


class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void changeTab(int idx) => emit(idx);
}
