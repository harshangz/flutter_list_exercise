import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_sample/data/list_data.dart';
import 'package:flutter_list_sample/data/list_data_cubit.dart';
import 'package:flutter_list_sample/presentation/detail_page.dart';

import '../utils/utility.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late ListDataCubit dataCubit;
  TextEditingController editingController = TextEditingController();
  var items = <RelatedTopics>[];

  @override
  void initState() {
    super.initState();
    dataCubit = BlocProvider.of<ListDataCubit>(context);
    dataCubit.getData();
  }

  void filterSearchResults(String query) {
      items = dataCubit.listRelatedTopics
          .where((item) =>
          item.text!.toLowerCase().contains(query.toLowerCase()))
          .toList();

      dataCubit.filterSearchData(items);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListDataCubit, FlowState>(
      buildWhen: (prev,curr)=> curr is UpdateListState || curr is FilterSearchListState,
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
        var listData = (state is FilterSearchListState)?state.res : dataCubit.listRelatedTopics;

        if (listData.isNotEmpty) {
          if(Utility.getDeviceType() == DeviceType.tablet) {
            dataCubit.updateDetailData(listData[0]);
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  onChanged: (value) {
                    if(value.length > 2) {
                      filterSearchResults(value);
                    } else if(value.length < 1) {
                      dataCubit.filterSearchData(dataCubit.listRelatedTopics);
                    }
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listData.length,
                    itemBuilder: (BuildContext context, int index) {
                      RelatedTopics objData = listData[index];
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
                          title: Text(objData.text?.split(" - ")[0] ?? " List item $index"),
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
                    }),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('No records found'),
          );
        }
      }
    });
  }
}
