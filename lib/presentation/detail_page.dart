import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_list_sample/utils/utility.dart';

import '../data/list_data.dart';
import '../data/list_data_cubit.dart';

class DetailPage extends StatefulWidget {
  RelatedTopics? relatedTopics;

  DetailPage({this.relatedTopics, super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ListDataCubit listDataCubit;

  @override
  void initState() {
    super.initState();
    listDataCubit = BlocProvider.of<ListDataCubit>(context);
    if(widget.relatedTopics != null) {
      listDataCubit.updateDetailData(widget.relatedTopics!);
    }
  }

  Widget detailWidget() {
    return SingleChildScrollView(
      child: BlocBuilder<ListDataCubit, FlowState>(
          buildWhen: (prev, cur) => cur is UpdateDetailState,
          builder: (context, state) {
            if (state is UpdateDetailState) {
              var imgUrl = state.relatedTopics.icon?.url ?? "";
              var title = state.relatedTopics?.text ?? "";

              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    (imgUrl.isNotEmpty)
                        ? FadeInImage.assetNetwork(
                            width: 160,
                            height: 180,
                            placeholder: "assets/img_placeholder.png",
                            image: "${Utility.baseImgUrl}$imgUrl")
                        : Image.asset(
                            "assets/img_placeholder.png",
                            width: 160,
                            height: 180,
                          ),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 21,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.indigo,
                  backgroundColor: Colors.white,
                ),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<ListDataCubit>(context),
        child: (Utility.getDeviceType() == DeviceType.phone)
            ? Scaffold(
                appBar: AppBar(),
                body: detailWidget(),
              )
            : detailWidget());
  }
}
