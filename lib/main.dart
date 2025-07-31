import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
//tatelessWidget을 상속받은 클래스
  const MyApp({super.key});
  //상태를 가지지 않으며 오직 ui만을 구성합니다
//const생성자를 사용하여 불변성확보 및 성능을 최적화
  @override
  Widget build(BuildContext context) {
    //플루터에서 ui를 그릴때 호출되는 핵심 매서드
//리턴값은 위젯트리이고 ChangeNotifierProvider로 시작합니다
return ChangeNotifierProvider(
  //프로바이더 패키지를 사용한 상태관리 방식입니다
  create: (context) => MyAppState(),
  //MyAppState()객체를 생성하고 앱 전체에 공급합니다
  //이객체는 ChangeNotifier를 상속해야 하며 배분변화시 UI를 갱신할수 있다
  child:MaterialApp(
    title:'타이틀 이므니다',
    theme:ThemeData(//앱의 전체적인 디자인 테마를 설정
      useMaterial3: true,
      colorScheme:ColorScheme.fromSeed(seedColor: Colors.deepOrange),
    ),
    home: MyHomePage(),
  ),
  );
  }
}

class MyAppState extends ChangeNotifier{
  var current = WordPair.random();
  //add this
  void getNext(){//이매서드는..임의의 새 WordPair를 큐런트에 재할당
  //또한 MyAppState를 보고있는 사람에게 알림을 보내는 notifyListeners()
  //체인지 노티파이어 메서드를 호출
    current = WordPair.random();
    notifyListeners();
  }
}
/*

 */

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    var appState = context.watch<MyAppState>();
//add this
var pair = appState.current;

    return Scaffold(
      body:Column(
        children: [
Text('A random AWESOME idea:'),
BigCard(pair: pair),
ElevatedButton(onPressed: (){
  appState.getNext();
  //print('button pressed!');
},
child:Text('Next'),
),
        ],),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Text(pair.asLowerCase);
  }
}
//앱을 대화식으로 진행하는것이 플루터를 알아가는 가장 좋은 방법입니다