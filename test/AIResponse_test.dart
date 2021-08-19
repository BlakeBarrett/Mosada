import 'dart:convert';

import 'package:test/test.dart';
import 'package:bbai/AIResponse.dart';

void main() {
  final jsonResponses = [
    jsonDecode(
        '{"id": "cmpl-3YOrBNtzvqNRSNbKhWBTPOK3YUsSP", "object": "text_completion", "created": 1629327713, "model": "davinci:2020-05-03", "choices": [{"text": "F0F0F0", "index": 0, "logprobs": null, "finish_reason": "stop"}]}'),
    jsonDecode(
        '{"id": "cmpl-3YPrAHaqZGdfFKBUPWXjxG0OiG6Xh", "object": "text_completion", "created": 1629331556, "model": "davinci:2020-05-03", "choices": [{"text": "FAFAFA", "index": 0, "logprobs": null, "finish_reason": "stop"}]}'),
  ];

  group('Initialization from JSON tests', () {
    test('Response can be parsed from JSON', () {
      final firstResponse = jsonResponses.first;
      final response = new AIResponse.fromJson(firstResponse);
      expect(response.id, 'cmpl-3YOrBNtzvqNRSNbKhWBTPOK3YUsSP');
      expect(response.object, 'text_completion');
      expect(response.created, 1629327713);
      expect(response.model, 'davinci:2020-05-03');
      expect(response.choices.length, 1);
    });

    test('Response Choice can be parsed from JSON', () {
      final choices = new AIResponse.fromJson(jsonResponses.first).choices;
      expect(choices.length, 1);
      final first = choices[0];
      expect(first.text, 'F0F0F0');
      expect(first.index, 0);
      expect(first.logprobs, null);
      expect(first.finish_reason, 'stop');
    });

    test('Multiple different responses are parsable', () {
      jsonResponses.forEach((element) {
        try {
          final value = AIResponse.fromJson(element);
          expect(value, isNotNull);
        } catch (e) {
          fail(e.toString());
        }
      });
    });
  });
}
