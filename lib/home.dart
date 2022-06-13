import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:vicetotext/api/api.dart';
import 'package:vicetotext/commant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, HighlightedWord> hightLighter = {
    "Muhammad": HighlightedWord(
        onTap: () {},
        textStyle:
            const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))
  };

  bool isListening = false;
  String text = "press to talk";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Voice To Text"),
          actions: [
            Builder(builder: (context) {
              return IconButton(
                  onPressed: () async {
                    await FlutterClipboard.copy(text);
                    Scaffold.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Text is copy',
                        style: TextStyle(fontSize: 20),
                      ),
                      backgroundColor: Colors.teal,
                    ));
                  },
                  icon: const Icon(Icons.copy));
            })
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: isListening,
          glowColor: Colors.teal,
          endRadius: 70,
          duration: const Duration(seconds: 2),
          repeatPauseDuration: const Duration(microseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: recording,
            child: Icon(isListening ? Icons.mic : Icons.mic_off),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: const EdgeInsets.all(30).copyWith(bottom: 100),
            child: TextHighlight(
              text: text,
              textStyle: const TextStyle(color: Colors.black, fontSize: 25),
              words: hightLighter,
            ),
          ),
        ));
  }

  Future recording() => SpeechApi.recording(
      onResult: (text) => setState(() => this.text = text),
      onListening: (isListening) {
        setState(() => this.isListening = isListening);

        if (!isListening) {
          Future.delayed(const Duration(seconds: 1), () {
            Utils.scanText(text);
          });
        }
      });
}
