
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi{
  static final speech = SpeechToText();
  static Future<bool> recording ({
  @required Function (String text) onResult,
  @required ValueChanged<bool> onListening,

})async{
    if(speech.isListening){
      speech.stop();
      return true;
    }
    final isAvailable =await speech.initialize(
      onStatus: (state) => onListening(speech.isListening),
        onError: (e) => print("onError: $e"),
      debugLogging: true
    );
    if(isAvailable){
      speech.listen(onResult: (value)=>onResult (value.recognizedWords));
    }
    return isAvailable;
}
}