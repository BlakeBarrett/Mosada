import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import 'AIResponse.dart';
import 'conversation_list.dart';
import 'secrets.dart' as secrets;

enum Engines { instruct, davinci }

enum State { Ready, Asking, Coloring, Error }
State _state = State.Ready;
State getState() => _state;
void setState(final State value) {
  _state = value;
}

bool isReady() => _state == State.Ready;

final List<String> _conversation = [];
void reset() {
  _conversation.clear();
}

final String _preamble =
    "The following is a conversation with your new AI friend Mosada. Mosada is friendly, empathetic, creative, artistic, and inquisitive.\n\nGreetings friend!\nHello, it is good to hear from you!\n";
String getPreamble() => _preamble;

Future<List<ConversationViewModel>> continueConversation(
    final String question) async {
  setState(State.Asking);
  final answer = await _askQuestion(question);
  final textResponses = getTextForResponse(answer);
  final List<ConversationViewModel> responses = [];
  setState(State.Coloring);
  for (final element in textResponses) {
    final color = await _getColor(element);
    responses.add(new ConversationViewModel(
        text: element, color: color, speaker: Speaker.Them));
  }
  setState(State.Ready);
  return responses;
}

List<String> getTextForResponse(final AIResponse? response) {
  return '${response?.choices?.first.text}'
      .split("\n")
      .where((value) => value.isNotEmpty)
      .toList();
}

Color getColorForResponse(final AIResponse response) {
  var colorString = response.choices?.first.text.split(';').first;
  // Converts #F00 to #FF0000 and so on.
  if (colorString?.length == 3) {
    final red = colorString?.substring(0, 1);
    final green = colorString?.substring(1, 2);
    final blue = colorString?.substring(2, 3);
    colorString = '$red$red$green$green$blue$blue';
  }
  try {
    return (colorString == '') ? Colors.white : HexColor('#$colorString');
  } catch (error) {
    print('$error');
    return Colors.white10;
  }
}

Future<Color> _getColor(final String query) async {
  final prompt =
      "The CSS code for a color like \"$query\":\n\nbackground-color: #";
  final response = await _execute(prompt, Engines.instruct, 0.0, 10);
  return getColorForResponse(response);
}

Future<AIResponse> _askQuestion(final String query) async {
  _conversation.add(query);
  final fullConversation = _preamble + _conversation.join('\n') + "\n";
  final response = await _execute(fullConversation, Engines.davinci, 0.7, 40);
  _conversation.addAll(getTextForResponse(response));
  return response;
}

String _getFriendlyEngine(final Engines engine) {
  switch (engine) {
    case Engines.instruct:
      return 'davinci-instruct-beta';
    case Engines.davinci:
      return 'davinci';
  }
}

Future<AIResponse> _execute(final String query, final Engines engine,
    final double temperature, final int budget) async {
  final String preferredEngine = _getFriendlyEngine(engine);
  final String url =
      'https://api.openai.com/v1/engines/$preferredEngine/completions';
  final Uri uri = Uri.parse(url);
  final Map postData = {
    "prompt": query,
    "stop": ["\n"],
    "temperature": temperature,
    "max_tokens": budget,
    "top_p": 0.9,
    "frequency_penalty": 0.5,
    "presence_penalty": 0.0,
  };
  final postBody = json.encode(postData);
  print(postBody);
  final result = await http.post(
    uri,
    headers: {
      HttpHeaders.authorizationHeader: "Bearer ${secrets.OPEN_AI_API_KEY}",
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    body: postBody,
  );
  print(result.body);
  try {
    return AIResponse.fromJson(jsonDecode(result.body));
  } catch (error) {
    print('$error');
    setState(State.Error);
    return AIResponse.fromError(error);
  }
}
