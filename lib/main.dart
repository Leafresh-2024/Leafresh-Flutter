import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/user_viewmodel.dart';
import 'views/login_page.dart';
import 'views/community_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: MaterialApp(
        title: 'User Profile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),  // HomeScreen에서 네비게이션 바 관리
        initialRoute: '/login', // 첫 페이지를 로그인 페이지로 설정
        routes: {
          '/login': (context) => LoginPage(),
          '/community': (context) => CommunityPage(),
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // 각 탭에 해당하는 화면 리스트
  static const List<Widget> _pages = <Widget>[
    HomePage(),     // HomePage 추가
    MarketPage(),   // MarketPage 추가
    CommunityPage(),  // CommunityPage 추가
    ProfilePage(),  // ProfilePage 추가
  ];

  // 탭 선택 시 호출
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  // 현재 선택된 페이지 표시
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Market',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
