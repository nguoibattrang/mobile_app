import 'dart:convert';

ResponseMessage responseMessageFromJson(String str) => ResponseMessage.fromJson(json.decode(str));

String responseMessageToJson(ResponseMessage data) => json.encode(data.toJson());

class ResponseMessage {
  String? event;
  String? taskId;
  String? id;
  String? messageId;
  String? conversationId;
  String? mode;
  String? answer;
  Metadata? metadata;
  int? createdAt;

  ResponseMessage({
    this.event,
    this.taskId,
    this.id,
    this.messageId,
    this.conversationId,
    this.mode,
    this.answer,
    this.metadata,
    this.createdAt,
  });

  ResponseMessage copyWith({
    String? event,
    String? taskId,
    String? id,
    String? messageId,
    String? conversationId,
    String? mode,
    String? answer,
    Metadata? metadata,
    int? createdAt,
  }) =>
      ResponseMessage(
        event: event ?? this.event,
        taskId: taskId ?? this.taskId,
        id: id ?? this.id,
        messageId: messageId ?? this.messageId,
        conversationId: conversationId ?? this.conversationId,
        mode: mode ?? this.mode,
        answer: answer ?? this.answer,
        metadata: metadata ?? this.metadata,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ResponseMessage.fromJson(Map<String, dynamic> json) => ResponseMessage(
    event: json["event"],
    taskId: json["task_id"],
    id: json["id"],
    messageId: json["message_id"],
    conversationId: json["conversation_id"],
    mode: json["mode"],
    answer: json["answer"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "event": event,
    "task_id": taskId,
    "id": id,
    "message_id": messageId,
    "conversation_id": conversationId,
    "mode": mode,
    "answer": answer,
    "metadata": metadata?.toJson(),
    "created_at": createdAt,
  };
}

class Metadata {
  Usage? usage;

  Metadata({
    this.usage,
  });

  Metadata copyWith({
    Usage? usage,
  }) =>
      Metadata(
        usage: usage ?? this.usage,
      );

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    usage: json["usage"] == null ? null : Usage.fromJson(json["usage"]),
  );

  Map<String, dynamic> toJson() => {
    "usage": usage?.toJson(),
  };
}

class Usage {
  int? promptTokens;
  String? promptUnitPrice;
  String? promptPriceUnit;
  String? promptPrice;
  int? completionTokens;
  String? completionUnitPrice;
  String? completionPriceUnit;
  String? completionPrice;
  int? totalTokens;
  String? totalPrice;
  String? currency;
  double? latency;

  Usage({
    this.promptTokens,
    this.promptUnitPrice,
    this.promptPriceUnit,
    this.promptPrice,
    this.completionTokens,
    this.completionUnitPrice,
    this.completionPriceUnit,
    this.completionPrice,
    this.totalTokens,
    this.totalPrice,
    this.currency,
    this.latency,
  });

  Usage copyWith({
    int? promptTokens,
    String? promptUnitPrice,
    String? promptPriceUnit,
    String? promptPrice,
    int? completionTokens,
    String? completionUnitPrice,
    String? completionPriceUnit,
    String? completionPrice,
    int? totalTokens,
    String? totalPrice,
    String? currency,
    double? latency,
  }) =>
      Usage(
        promptTokens: promptTokens ?? this.promptTokens,
        promptUnitPrice: promptUnitPrice ?? this.promptUnitPrice,
        promptPriceUnit: promptPriceUnit ?? this.promptPriceUnit,
        promptPrice: promptPrice ?? this.promptPrice,
        completionTokens: completionTokens ?? this.completionTokens,
        completionUnitPrice: completionUnitPrice ?? this.completionUnitPrice,
        completionPriceUnit: completionPriceUnit ?? this.completionPriceUnit,
        completionPrice: completionPrice ?? this.completionPrice,
        totalTokens: totalTokens ?? this.totalTokens,
        totalPrice: totalPrice ?? this.totalPrice,
        currency: currency ?? this.currency,
        latency: latency ?? this.latency,
      );

  factory Usage.fromJson(Map<String, dynamic> json) => Usage(
    promptTokens: json["prompt_tokens"],
    promptUnitPrice: json["prompt_unit_price"],
    promptPriceUnit: json["prompt_price_unit"],
    promptPrice: json["prompt_price"],
    completionTokens: json["completion_tokens"],
    completionUnitPrice: json["completion_unit_price"],
    completionPriceUnit: json["completion_price_unit"],
    completionPrice: json["completion_price"],
    totalTokens: json["total_tokens"],
    totalPrice: json["total_price"],
    currency: json["currency"],
    latency: json["latency"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "prompt_tokens": promptTokens,
    "prompt_unit_price": promptUnitPrice,
    "prompt_price_unit": promptPriceUnit,
    "prompt_price": promptPrice,
    "completion_tokens": completionTokens,
    "completion_unit_price": completionUnitPrice,
    "completion_price_unit": completionPriceUnit,
    "completion_price": completionPrice,
    "total_tokens": totalTokens,
    "total_price": totalPrice,
    "currency": currency,
    "latency": latency,
  };
}
