import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/CartBloc/cart_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_responsive_ui/widgets/custom_app_bar.dart';
import '../models/content_model.dart';
import '../widgets/responsive.dart';

class Cart extends StatelessWidget {
  final Content content;
  final CartBloc blocCart;
   List<Content> contentList;

   Cart({Key key, this.content, this.blocCart, contentList,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    print('Insiide the cart build method');
    // var blocCart = Provider.of<CartBloc>(context);
    var cart = blocCart.cart;
    return BlocProvider(
  create: (context) => AppBarCubit(),
  child: Scaffold(
      // appBar:
      // PreferredSize(
      //   preferredSize: Size(screenSize.width, 50),
      //   child: BlocBuilder<AppBarCubit, double>(
      //     builder: (context, scrollOffset) {
      //       return CustomAppBar(
      //         scrollOffset: scrollOffset,
      //       );
      //     },
      //   ),
      // ),
      body: Responsive(
        desktop: DesktopCartView(cart: cart,blocCart: blocCart,content: content,),
        mobile: MobileCartView(cart: cart,blocCart: blocCart,content: content,),
      ),
    ),
);
  }
}

class DesktopCartView extends StatelessWidget {
  final Map<int, int> cart;
  final CartBloc blocCart;
  final Content content;
  final List<Content> contentList;



  const DesktopCartView({Key key, this.cart, this.blocCart, this.content, this.contentList, }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cart.length,
        itemBuilder: (context, index) {
          int giftIndex = cart.keys.toList()[index];
          int count = cart[giftIndex];
          return ListTile(
          leading: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 18.0),
            height: 40,
            width: 20,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(content.imageUrl),
                    fit: BoxFit.cover)),
          ),
          title: Text('Item Count: $count', style: TextStyle(color: Colors.red),),

        );
        });
  }
}

class MobileCartView extends StatelessWidget {
  final Map<int, int> cart;
  final CartBloc blocCart;
  final Content content;
  final List<Content> contentList;




  const MobileCartView({Key key, this.cart, this.blocCart, this.content, this.contentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          int giftIndex = cart.keys.toList()[index];
          int count = cart[giftIndex];
          return ListTile(
            tileColor: Colors.white12,
            leading: Container(
              height: 70,
              width: 35,
              // margin: const EdgeInsets.symmetric(horizontal: 18.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(content.imageUrl),
                      fit: BoxFit.cover)),
            ),
            title: Text('Item Count: $count', style: TextStyle(color: Colors.red),),
            onTap: (){},
          );
        });
  }
}
