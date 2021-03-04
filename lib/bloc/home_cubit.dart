import 'package:blocpatten/bloc/data_repository.dart';
import 'package:blocpatten/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HttpRepository _httpRepository;
  HomeCubit(this._httpRepository) : super(HomeInitial());

  Future<void> getData() async {



    try{
      emit(HomeLoading());
      await Future.delayed(Duration(microseconds: 500));
      final response = await _httpRepository.getData();
      print(response.toString());
      emit(HomeCompleted(response));
    } catch(e){
      emit(HomeError("Couldn't fetch responses "));
    }
  }

}



