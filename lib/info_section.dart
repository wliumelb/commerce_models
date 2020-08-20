import 'dart:ui';

/// One section of the diaplayed content; could represent a photo, a title or some text
class InfoSectionModel {
  final String photoUrl;
  final String title;
  final String text;
  InfoSectionModel({
    this.title,
    this.photoUrl,
    this.text,
  }) : assert(title != null || photoUrl != null || text != null);

  static InfoSectionModel fromMap(Map<String, dynamic> map) {
    return InfoSectionModel(
      title: map['title'],
      photoUrl: map['photoUrl'],
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'photoUrl': this.photoUrl,
      'text': this.text,
    };
  }

  String toString() =>
      'InfoSectionModel(title: ${title ?? 'none'}, photoUrl: ${photoUrl ?? 'none'}, text: ${text ?? 'none'})';

  @override
  bool operator ==(dynamic o) {
    return o is InfoSectionModel && o.toString() == this.toString();
  }

  @override
  int get hashCode => hashValues(this.title, this.photoUrl, this.text);
}
