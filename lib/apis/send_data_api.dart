import 'dart:convert';

import 'package:http/http.dart' as http;

Future submitData({
  required String firstName,
  required String lastName,
  required String email,
  required String phone,
  required String photo,
}) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://dev3.xicom.us/xttest/savedata.php'));
  request.fields.addAll({
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone': phone,
  });
  request.files.add(await http.MultipartFile.fromPath('user_image', photo));
  print(request.fields);
  http.StreamedResponse response = await request.send();
  var resp = jsonDecode(await response.stream.bytesToString());
  if (response.statusCode == 200) {
    print(resp);
    return resp;
  } else {
    print(resp);
    print(response.reasonPhrase);
    print(response.statusCode);
    return resp;
  }
}
