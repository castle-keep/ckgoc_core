import 'package:flutter/widgets.dart';

class DocParam {
  const DocParam({
    required this.name,
    required this.type,
    required this.description,
    this.requiredParam = false,
    this.defaultValue,
  });

  final String name;
  final String type;
  final String description;
  final bool requiredParam;
  final String? defaultValue;
}

class DocFaq {
  const DocFaq({required this.question, required this.answer});

  final String question;
  final String answer;
}

class EnumCaseDoc {
  const EnumCaseDoc({required this.name, required this.description});

  final String name;
  final String description;
}

class ComponentDocData {
  const ComponentDocData({
    required this.title,
    required this.summary,
    required this.demo,
    required this.code,
    required this.params,
    required this.faqs,
    this.comingSoon = false,
    this.notes = const <String>[],
  });

  final String title;
  final String summary;
  final Widget demo;
  final String code;
  final List<DocParam> params;
  final List<DocFaq> faqs;
  final List<String> notes;
  final bool comingSoon;
}
