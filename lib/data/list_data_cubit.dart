import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_sample/network/api_call_manager.dart';

import 'list_data.dart';


class FlowState extends Equatable {
  dynamic result;

  FlowState({this.result});

  @override
  List<Object?> get props => [result];
}

enum StateRenderType{
  DEFAULT,
  LOADING,
  ERROR
}

class LoadingState extends FlowState {
  final StateRenderType stateRenderType;
  LoadingState({required this.stateRenderType});

  @override
  List<Object?> get props => [stateRenderType];
}

class UpdateListState extends FlowState {
  dynamic res;
  UpdateListState({this.res});

  @override
  List<Object?> get props => [res];
}

class UpdateDetailState extends FlowState {
  final dynamic relatedTopics;
  UpdateDetailState({required this.relatedTopics});

  @override
  List<Object?> get props => [relatedTopics];
}

class ListDataCubit extends Cubit<FlowState> {

  ListDataCubit() :super(FlowState());

  List<RelatedTopics> listRelatedTopics = [];

  Future<void> getData() async {
    emit(LoadingState(stateRenderType: StateRenderType.LOADING));
    var res = await ApiCallManager().getSimsonData();
    print("Result==>$res");
    res.relatedTopics?.forEach((element) {
      listRelatedTopics.add(element);
    });

    emit(UpdateListState(res:res));
  }

  updateDetailData(RelatedTopics relatedTopics) {
    emit(UpdateDetailState(relatedTopics: relatedTopics));
  }
}