class AIResponse {
  final String? id;
  final String? object;
  final int? created;
  final String? model;
  final List<AIResponseChoice>? choices;

  AIResponse(
      {required this.id,
      required this.object,
      required this.created,
      required this.model,
      required this.choices});

  factory AIResponse.fromJson(final Map<String, dynamic> json) {
    return new AIResponse(
        id: json["id"],
        object: json["object"],
        created: int.parse('${json["created"]}'),
        model: json["model"],
        choices: (json["choices"] as List)
            .map((value) => AIResponseChoice.fromJson(value))
            .toList());
  }

  factory AIResponse.fromError(final error) {
    return new AIResponse(
        id: "", object: '$error', created: 0, model: "", choices: []);
  }
}

class AIResponseChoice {
  final String text;
  final int index;
  final List<int>? logprobs;
  // ignore: non_constant_identifier_names
  final String finish_reason;

  AIResponseChoice(
      {required this.text,
      required this.index,
      required this.logprobs,
      // ignore: non_constant_identifier_names
      required this.finish_reason});

  factory AIResponseChoice.fromJson(final Map<String, dynamic> json) =>
      new AIResponseChoice(
          text: json["text"],
          index: json["index"],
          logprobs: json["logprobs"],
          finish_reason: json["finish_reason"]);
}
