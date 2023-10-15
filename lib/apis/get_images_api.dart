import 'dart:convert';

import 'package:http/http.dart' as http;

Future getImagesApi({
  required String load,
}) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://dev3.xicom.us/xttest/getdata.php?user_id=108&offset=0&type=popular'));
  request.fields.addAll({'user_id': '108', 'offset': load, 'type': 'popular'});
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.statusCode);
    print(response.reasonPhrase);
    return resp;
  }
}
