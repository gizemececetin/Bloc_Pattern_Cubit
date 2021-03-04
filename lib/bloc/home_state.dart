import 'package:blocpatten/models/post_model.dart';
import 'package:flutter/foundation.dart';

abstract class HomeState{
  const HomeState();
}

class HomeInitial extends HomeState{
  const HomeInitial();
}

class HomeLoading extends HomeState{
  const HomeLoading();
}

class HomeCompleted extends HomeState{
  final List<PostModel> response;
  const HomeCompleted(this.response);

  @override
  bool operator ==(Object other) {
    if(identical(this,other)) return true;

    return other is HomeCompleted && listEquals(other.response, response);
  }

  @override
  int get hashCode => response.hashCode;

}
class HomeError extends HomeState{
  final String message;
  const HomeError(this.message);
}