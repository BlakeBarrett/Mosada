import 'dart:io';
import 'dart:convert';
import 'package:bbai/AIResponse.dart';
import 'package:http/http.dart' as http;
import 'secrets.dart' as secrets;

Future<AIResponse> get(String query) async {
  final String url = 'https://api.openai.com/v1/engines/davinci/completions';
  final Uri uri = Uri.parse(url);
  Map postData = {
    "prompt": "The CSS code for a color like $query:\n\nbackground-color: #",
    "stop": [";"],
    "temperature": 0,
    "max_tokens": 69,
    "top_p": 1.0,
    "frequency_penalty": 0.0,
    "presence_penalty": 0.0,
  };
  final postBody = json.encode(postData);
  var result = await http.post(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${secrets.OPEN_AI_API_KEY}",
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: postBody,
  );
  print(result.body);
  return AIResponse.fromJson(jsonDecode(result.body));
}
