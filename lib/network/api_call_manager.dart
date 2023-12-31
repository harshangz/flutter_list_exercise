
import 'package:flutter_list_sample/data/list_data.dart';
import '../utils/utility.dart';
import 'network_util.dart';

class ApiCallManager {
  final NetworkUtil _netUtil = NetworkUtil();
  static const baseUrl = "http://api.duckduckgo.com";
  //com.sample.simpsonsviewer
  static const listSimsonsUrl = "$baseUrl/?q=simpsons+characters&format=json";
  // com.sample.wireviewer
  static const listWireUrl = "$baseUrl/?q=the+wire+characters&format=json";

  Future<ListData> getSimsonData() {
    final url = (Utility.buildFlavor == "wire") ? listWireUrl :listSimsonsUrl;
    return _netUtil.get(url).then((dynamic res) {
      print(res.toString());
      return ListData.fromJson(res);
    });
  }
}
