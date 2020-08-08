import 'package:commerce_models/info_section.dart';

final infoSectionTestData = [
  {
    'input': {
      'photoUrl': 'testUrl1',
    },
    'value': 'title: none, photoUrl: testUrl1, text: none',
  },
  {
    'input': {
      'title': 'Title One',
    },
    'value': 'title: Title One, photoUrl: none, text: none',
  },
  {
    'input': {
      'text': 'Paragraph One\nParagraph Two\nParagraph Three',
    },
    'value':
        'title: none, photoUrl: none, text: Paragraph One\nParagraph Two\nParagraph Three',
  },
];

final List<InfoSectionModel> infoSectionList = infoSectionTestData.map((map) {
  final inputMap = Map<String, dynamic>.from(map['input']);
  return InfoSectionModel.fromMap(inputMap);
}).toList();
