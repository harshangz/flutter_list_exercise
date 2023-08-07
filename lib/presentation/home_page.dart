import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/list_data_cubit.dart';
import '../injection_manager.dart';
import '../utils/Utility.dart';
import 'detail_page.dart';
import 'list_page.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  ListDataCubit dataCubit = getIt<ListDataCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('The Simpsons characters'),
      ),
      body: BlocProvider(
        create: (_) => dataCubit,
        child: BlocBuilder<ListDataCubit,FlowState>(
          builder:(context,state) {

          return Center(
            child: (Utility.getDeviceType() == DeviceType.tablet) ? Row(
              children: [
                const Flexible(
                    flex: 4,
                    child: ListWidget()),
                Flexible(
                    flex: 6,
                    child: BlocProvider.value(
                        value: dataCubit,
                        child: DetailPage()))
              ],
            ) : ListWidget(),
          );}
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
