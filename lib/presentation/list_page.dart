import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_sample/data/list_data_cubit.dart';
import 'package:flutter_list_sample/presentation/detail_page.dart';

import '../data/list_data.dart';
import '../utils/Utility.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late ListDataCubit dataCubit;

  @override
  void initState() {
    super.initState();
    dataCubit = BlocProvider.of<ListDataCubit>(context);
    dataCubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListDataCubit, FlowState>(
      buildWhen: (prev,curr)=> curr is! UpdateDetailState,
        builder: (context, state) {
      if (state is LoadingState) {
        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.indigo,
            backgroundColor: Colors.white,
          ),
        );
      } else {
        if (dataCubit.listRelatedTopics.isNotEmpty) {
          if(Utility.getDeviceType() == DeviceType.tablet) {
            dataCubit.updateDetailData(dataCubit.listRelatedTopics[0]);
          }
          return ListView.builder(
              shrinkWrap: true,
              itemCount: dataCubit.listRelatedTopics.length,
              itemBuilder: (BuildContext context, int index) {
                RelatedTopics objData = dataCubit.listRelatedTopics[index];
                var imgUrl = objData.icon?.url ?? "";
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () {
                      if(Utility.getDeviceType() == DeviceType.tablet) {
                        dataCubit.updateDetailData(objData);
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                BlocProvider.value(
                                    value: dataCubit,
                                    child: DetailPage(relatedTopics: objData,))));
                      }
                    },
                    title: Text('List item $index'),
                    trailing: (imgUrl.isNotEmpty)
                        ? FadeInImage.assetNetwork(
                            width: 60,
                            height: 60,
                            image: "${Utility.baseImgUrl}$imgUrl",
                            placeholder: "assets/img_placeholder.png",
                          )
                        : Image.asset(
                      "assets/img_placeholder.png",
                            width: 60,
                            height: 60,),
                  ),
                );
              });
        } else {
          return const Center(
            child: Text('No records found'),
          );
        }
      }
    });
  }
}
