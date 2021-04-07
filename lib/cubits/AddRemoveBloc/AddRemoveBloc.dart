import 'dart:async';
import 'package:bloc/bloc.dart';


enum AddRemoveEvent { increment, decrement }

class AddRemoveBloc extends Bloc<AddRemoveEvent, int> {
  AddRemoveBloc(int initialState) : super(initialState);


  @override
  Stream<int> mapEventToState(AddRemoveEvent event) async* {
    switch (event) {
      case AddRemoveEvent.decrement:
        yield state - 1;
        break;
      case AddRemoveEvent.increment:
        yield state + 1;
        break;
    }
  }
}