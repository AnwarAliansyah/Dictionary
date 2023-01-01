class Dictionary {
  Dictionary({
    this.word,
    this.phonetic,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  String? word;
  String? phonetic;
  List<Phonetic>? phonetics;
  List<Meaning>? meanings;
  License? license;
  List<String>? sourceUrls;

  factory Dictionary.fromJson(Map<String, dynamic> json) => Dictionary(
        word: json["word"],
        phonetic: json["phonetic"],
        phonetics: List<Phonetic>.from(
            json["phonetics"].map((x) => Phonetic.fromJson(x))),
        meanings: List<Meaning>.from(
            json["meanings"].map((x) => Meaning.fromJson(x))),
        license: License.fromJson(json["license"]),
        sourceUrls: List<String>.from(json["sourceUrls"].map((x) => x)),
      );
}

class License {
  License({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
      );
}

class Meaning {
  Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  String? partOfSpeech;
  List<Definition>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<String>.from(json["antonyms"].map((x) => x)),
      );
}

class Definition {
  Definition({
    this.definition,
    this.synonyms,
    this.antonyms,
    this.example,
  });

  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<String>.from(json["antonyms"].map((x) => x)),
        example: json["example"] == null ? "" : json["example"],
      );
}

class Phonetic {
  Phonetic({
    this.text,
    this.audio,
    this.sourceUrl,
    this.license,
  });

  String? text;
  String? audio;
  String? sourceUrl;
  License? license;

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        text: json["text"],
        audio: json["audio"],
        sourceUrl: json["sourceUrl"] == null ? null : json["sourceUrl"],
        license:
            json["license"] == null ? null : License.fromJson(json["license"]),
      );
}
