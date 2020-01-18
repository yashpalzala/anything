import 'package:flutter/material.dart';
import 'package:clevercheckin/utils/utils.dart';

class BottomNavBar extends StatefulWidget {
  final ValueChanged<int> changeCurrentTab;

  BottomNavBar({Key key, this.changeCurrentTab}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with SingleTickerProviderStateMixin {
  int tab = 0;

  Screen size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      iconSize: size.getWidthPx(24),
      currentIndex: tab,
      unselectedItemColor: Colors.black45,
      //selectedItemColor: colorCurve,
      elevation: 150.0,
      selectedFontSize: 15.0,
      showUnselectedLabels: true,
      onTap: (int index) {
        setState(() {
          if (index != 4) {
            tab = index;
            widget.changeCurrentTab(index);
          }
        });
      },
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.grey.shade50,
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds){
              return ccRadialGradient.createShader(bounds);
            },
            child: Icon(Icons.home)
          ),
          icon: Icon(Icons.home, color: Colors.grey),
          title: Text('Explore', style: ccText3),
        ),
        BottomNavigationBarItem(
          //backgroundColor: Colors.grey.shade50,
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds){
              return ccRadialGradient.createShader(bounds);
            },
            child: Icon(Icons.favorite),
          ),
          icon: Icon(Icons.favorite, color: Colors.grey),
          title: Text('Favourites', style: ccText3),
        ),
        BottomNavigationBarItem(
          //backgroundColor: Colors.grey.shade50,
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds){
              return ccRadialGradient.createShader(bounds);
            },
            child: Icon(Icons.person),
          ),
          icon: Icon(Icons.person, color: Colors.grey),
          title: Text('My Properties', style: ccText3),
        ),
        BottomNavigationBarItem(
          //backgroundColor: Colors.grey.shade50,
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds){
              return ccRadialGradient.createShader(bounds);
            },
            child: Icon(Icons.settings),
          ),
          icon: Icon(Icons.settings, color: Colors.grey),
          title: Text('Setting', style: ccText3),
        ),
      ],
    );
  }
}
