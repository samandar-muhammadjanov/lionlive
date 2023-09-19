import "dart:convert";

import "package:firebase_auth/firebase_auth.dart";
import "package:http/http.dart" as http;

class Repository {
  Future<String> buyPremiuim(String plan) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://checkout-i4ixhye4aq-uc.a.run.app/'));
    request.body = json.encode(
        {"plan": plan, "authID": FirebaseAuth.instance.currentUser!.uid});
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
    final body = json.decode(response.body);
    if (response.statusCode == 200) {
      return body["url"];
    } else {
      return throw Exception(response.body);
    }
  }
}
