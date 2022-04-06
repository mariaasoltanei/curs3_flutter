import 'package:curs3_flutter/widgets/phrase_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const LanguageButtons());
}

class LanguageButtons extends StatelessWidget {
  const LanguageButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LanguageButtonsApp(),
    );
  }
}

class LanguageButtonsApp extends StatefulWidget {
  const LanguageButtonsApp({Key? key}) : super(key: key);

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<LanguageButtonsApp> {
  GoogleTranslator translator = GoogleTranslator();
  List<String> englishPhrases = <String>['hello', 'how are you?', 'bye', 'how old are you?'];
  List<String> phrases = [];
  String language = 'sv';

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    translate();
    super.initState();
  }

  Future<void> translate() async {
    for (final String phrase in englishPhrases) {
      final Translation translation = await translator.translate(phrase, to: language);
      final String translatedText = translation.text;
      phrases..add(phrase)..add(translatedText);
    }
  }

  Future<void> speak(String languageCode, String text) async {
    await flutterTts.setLanguage(languageCode);
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(0.3);
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Basic phrases',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: phrases.length,
          itemBuilder: (BuildContext context, int index) {
            return PhraseButton(
                text: phrases[index],
                callback: () {
                  if (index.isEven) {
                    speak('en', phrases[index]);
                  } else {
                    speak(language, phrases[index]);
                  }
                },);
          },),
    );
  }
}
