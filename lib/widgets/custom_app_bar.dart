import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/widgets/responsive.dart';

import '../assets.dart';

class CustomAppBar extends StatelessWidget {
  final double scrollOffset;

  const CustomAppBar({Key key, this.scrollOffset = 0.0}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
        color: Colors.black.withOpacity((scrollOffset/350).clamp(0, 1).toDouble()),
      child: Responsive(
        mobile: _CustomAppBarMobile(),
        desktop: _CustomAppBarDesktop(),
      )
    );
  }
}
class _CustomAppBarMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo0),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: 'TV Shows', onTap:()=> print('TV Shows'),),
                _AppBarButton(title: 'Movies',onTap: () => print('Movies'),),
                _AppBarButton(title: 'My List',onTap: ()=> print('My List'),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
class _CustomAppBarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Image.asset(Assets.netflixLogo1),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AppBarButton(title: 'Home',onTap: ()=> print('Home'),),
                _AppBarButton(title: 'TV Shows', onTap:()=> print('TV Shows'),),
                _AppBarButton(title: 'Movies',onTap: () => print('Movies'),),
                _AppBarButton(title: 'My List',onTap: ()=> print('My List'),),
                _AppBarButton(title: 'Latest',onTap: ()=> print('Latest'),)
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: ()=> print('Home'),
                  padding: EdgeInsets.zero,
                  iconSize: 20.0,
                  color: Colors.white,
                ),
                _AppBarButton(title: 'KIDS', onTap:()=> print('KIDS'),),
                _AppBarButton(title: 'DVD',onTap: () => print('DVD'),),
                IconButton(
                  icon: Icon(Icons.card_giftcard),
                  onPressed: ()=> print('Gift'),
                  padding: EdgeInsets.zero,
                  iconSize: 20.0,
                  color: Colors.white,
                ),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: ()=> print('Notifications'),
                    padding: EdgeInsets.zero,
                    iconSize: 20.0,
                    color: Colors.white,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



class _AppBarButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const _AppBarButton({Key key, this.title, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
