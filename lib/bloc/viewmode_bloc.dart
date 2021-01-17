import 'package:flutter_bloc/flutter_bloc.dart';

class ViewModeBloc extends Bloc<ViewModeEvent, ViewModeState>{
  ViewModeBloc() : super(ViewModeStateShort());

  @override
  Stream<ViewModeState> mapEventToState(event) async* {
    if (event is ViewModeEventInit){
      yield ViewModeStateShort();
    }else if (event is ViewModeEventUp) {
      final newState = state.up();
      if (newState != null) yield newState;
    }else if (event is ViewModeEventDown) {
      final newState = state.down();
      if (newState != null) yield newState;
    }
  }
}

abstract class ViewModeEvent {}
class ViewModeEventInit extends ViewModeEvent{}
class ViewModeEventUp extends ViewModeEvent{}
class ViewModeEventDown extends ViewModeEvent{}

abstract class ViewModeState {
  ViewModeState up(){return null;}
  ViewModeState down(){return null;}
}
class ViewModeStateShort extends ViewModeState{
  @override
  ViewModeState down() {return ViewModeStateMini();}
  @override
  ViewModeState up() {return ViewModeStateFull();}
}
class ViewModeStateFull extends ViewModeState{
  @override
  ViewModeState down() {return ViewModeStateShort();}
}
class ViewModeStateMini extends ViewModeState{
  @override
  ViewModeState up() {return ViewModeStateShort();}
}
