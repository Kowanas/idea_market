import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea_market/model/idea_repository.dart';

class IdeaBloc extends Bloc<IdeaEvent, IdeaState>{
  final IdeaRepository ideaRepository;
  IdeaBloc(this.ideaRepository) : super(IdeaStateNotInitialized());

  @override
  Stream<IdeaState> mapEventToState(IdeaEvent event) async* {
    if (event is IdeaEventFetching){
      await ideaRepository.fetch();
      yield IdeaStateFetched();
    }else if (event is IdeaEventSaving){
      ideaRepository.set(event.idea);
      await ideaRepository.save();
      yield IdeaStateFetched();
    }else if (event is IdeaEventDeleting){
      ideaRepository.delete(event.idea.uid);
      await ideaRepository.save();
      yield IdeaStateFetched();
    }
  }
}

abstract class IdeaState {}
class IdeaStateNotInitialized extends IdeaState{}
class IdeaStateFetched extends IdeaState{}

abstract class IdeaEvent {
  final idea;
  IdeaEvent(this.idea);
}
class IdeaEventFetching extends IdeaEvent{
  IdeaEventFetching() : super(null);
}
class IdeaEventSaving extends IdeaEvent{
  IdeaEventSaving(idea) : super(idea);
}
class IdeaEventDeleting extends IdeaEvent{
  IdeaEventDeleting(idea) : super(idea);
}
