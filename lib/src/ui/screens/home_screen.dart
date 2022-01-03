import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_with_riverpod/src/providers/navigation_notifier.dart';
import 'package:movies_with_riverpod/src/resources/colors.dart';
import 'package:movies_with_riverpod/src/ui/pages/movies/movies_principal_page.dart';

final position = ChangeNotifierProvider((ref) => NavigationNotifier());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      const MoviesPrincipalPage(),
    ];
    return Consumer(builder: (_, ref, __){
      int _selectIndex = ref.watch(position).currentPosition;
      return Scaffold(
        appBar: AppBar(
          title: _selectIndex == 0
              ? const Text('Peliculas')
              : const Text('Series'),
          backgroundColor: WlColors.two,
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Películas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: 'Series',
            ),
          ],
          currentIndex: _selectIndex,
          selectedItemColor: WlColors.two,
          onTap: (index) {
            ref.watch(position).change(index);
          },
        ),
      );
    });
  }
}
