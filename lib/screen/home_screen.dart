import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/cubits/AddRemoveBloc/AddRemoveBloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/CartBloc/cart_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';
import 'package:flutter_netflix_responsive_ui/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../models/content_model.dart';
import 'cart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController;
  List<Content> myListt;



  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() {
      context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    var blocCart = Provider.of<CartBloc>(context);
    int totalCount = 0;
    if (blocCart.cart.length > 0) {
      totalCount = blocCart.cart.values.reduce((a, b) => a + b);
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton.extended(
          icon: Stack(
            children: <Widget>[
              new Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              new Positioned(
                  child: new Stack(
                    children: <Widget>[
                      new Icon(Icons.brightness_1,
                          size: 20.0, color: Colors.red[700]),
                      new Positioned(
                          top: 3.0,
                          right: 7,
                          child: new Center(
                            child: new Text(
                              '$totalCount',
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
                    ],
                  )),
            ],
          ),
          backgroundColor: Colors.grey[850],
          onPressed: () {
            print('Insiide the cart');
          },
          label: Text('Cart'),
        ),
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset){
            return CustomAppBar(scrollOffset: scrollOffset,);
          },
            ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: ContentHeader(
              featuredContent : sintelContent
            ),
          ),
          SliverPadding(padding:  const EdgeInsets.only(top : 20),
            sliver: SliverToBoxAdapter(
              child: Previews(
                key: PageStorageKey('previews'),
                title : 'Upcoming Poster Preview',
                contentList : previews
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ContentList(
                        key: PageStorageKey('My List'),
                        title : 'My List',
                        contentList : myList,
              totalCount: totalCount,
              blocCart: blocCart,
                      ),
          ),

        ],
      ),
    );
  }
}
