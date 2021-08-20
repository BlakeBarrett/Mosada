import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:bbai/AIResponse.dart';
import 'package:http/http.dart' as http;

import 'secrets.dart' as secrets;

List<String> _conversation = [];

void reset() {
  _conversation = [];
}

String getTextForResponse(final AIResponse? response) {
  return response?.choices.first.text ?? '';
}

Future<Color> getColor(final String query) async {
  final prompt =
      "The CSS code for a color like \"$query\":\n\nbackground-color: #";
  final response = await _execute(prompt);
  final colorString = "0xFF${response.choices.first.text}";
  try {
    final colorInt = int.parse(colorString);
    return Color(colorInt);
  } catch (e) {
    print(e);
  }
  return Color.fromARGB(00, 0xFF, 0xFF, 0xFF);
}

Future<AIResponse> askQuestion(final String query) async {
  // final prompt = "Me: $query\n\nMosada: #;";
  final introduction =
      "The following is a conversation with your new AI friend Mosada. Mosada is friendly, empathetic, creative, inquisitive.\n\n";
  final prompt = "Me: $query";
  _conversation.add(prompt);
  final fullConversation =
      introduction + _conversation.join('\n') + "\nMosada: ";
  final response = await _execute(fullConversation);
  _conversation.add("Mosada: ${getTextForResponse(response)}");
  return response;
}

Future<AIResponse> _execute(final String query) async {
  final String url = 'https://api.openai.com/v1/engines/davinci/completions';
  final Uri uri = Uri.parse(url);
  Map postData = {
    "prompt": query,
    "stop": [";"],
    "temperature": 0,
    "max_tokens": 69,
    "top_p": 1.0,
    "frequency_penalty": 0.0,
    "presence_penalty": 0.0,
  };
  final postBody = json.encode(postData);
  final result = await http.post(
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
