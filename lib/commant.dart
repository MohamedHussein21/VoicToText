import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all =[email,browser1,browser2];
  static const email ='write email' ;
  static const browser1 ='go to' ;
  static const browser2 ='open' ;
}

class Utils {
static void scanText (String rowText){
  final text =rowText.toLowerCase();

  if(text.contains(Command.email)){
    final body =  getTextAfterCommend(text: text, command: Command.email);
openEmail(body: body);
  }else if (text.contains(Command.browser1)){
    final url = getTextAfterCommend(text: text, command: Command.browser1);
openLink(url: url);
  }else if (text.contains(Command.browser2)){
    final url = getTextAfterCommend(text: text, command: Command.browser2);
    openLink(url: url);
  }
}

static String getTextAfterCommend ({
  @required String text,
  @required String command,
})
{
  final indexCommand = text.indexOf(command);
  final indexAfter = indexCommand + command.length;

  if(indexCommand == -1){
    return null;

  }else{
    return text.substring(indexAfter).trim();
  }
}

static Future openEmail ({
  @required String body,
})async{
  final url = 'mailto : ?body =${Uri.encodeFull(body)}';
  await _launcherUrl(url);
}
static Future _launcherUrl (String url)async{
  if(await canLaunch(url)){
    await launch(url);
  }
}

  static void openLink({@required String url}) async{
  if(url.trim().isEmpty){
    await _launcherUrl('https://google.com');
  }else{
    await _launcherUrl('https://$url ');
  }
  }
}