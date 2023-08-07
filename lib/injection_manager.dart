
import 'package:flutter_list_sample/data/list_data_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory(() => ListDataCubit());
}