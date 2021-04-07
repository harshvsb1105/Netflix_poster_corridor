import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/AddRemoveBloc/AddRemoveBloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/CartBloc/cart_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/app_bar/app_bar_cubit.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:flutter_netflix_responsive_ui/screen/cart.dart';
import 'package:flutter_netflix_responsive_ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../widgets/responsive.dart';

class SelectedItemPage extends StatefulWidget {
  final Content content;
  final int index;
  int totalCount;

  SelectedItemPage({Key key, this.content, this.index, this.totalCount})
      : super(key: key);

  @override
  _SelectedItemPageState createState() => _SelectedItemPageState();
}

class _SelectedItemPageState extends State<SelectedItemPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.bloc<AppBarCubit>().setOffset(_scrollController.offset);
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var blocCart = Provider.of<CartBloc>(context);
    widget.totalCount = 0;
    if (blocCart.cart.length > 0) {
      widget.totalCount = blocCart.cart.values.reduce((a, b) => a + b);
    }
    final screenSize = MediaQuery
        .of(context)
        .size;

    return BlocProvider(
      create: (_) => AppBarCubit(),
      child: Scaffold(
        floatingActionButtonLocation: Responsive.isDesktop(context)
            ? FloatingActionButtonLocation.centerFloat
            : null,
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
                              '${widget.totalCount}',
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
            Get.to(
                Cart(content: widget.content, blocCart: blocCart,));
          },
          label: Text('Move to cart'),
        ),
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50),
          child: BlocBuilder<AppBarCubit, double>(
            builder: (context, scrollOffset) {
              return CustomAppBar(
                scrollOffset: scrollOffset,
              );
            },
          ),
        ),
        body: Responsive(
          desktop: BlocProvider(
            create: (_) => AddRemoveBloc(0),
            child: DesktopView(
              scrollController: _scrollController,
              content: widget.content,
              blocCart: blocCart,
              index: widget.index,
              totalCount: widget.totalCount,
            ),
          ),
          mobile: BlocProvider(
            create: (_) => AddRemoveBloc(0),
            child: MobileView(
                scrollController: _scrollController,
                content: widget.content,
                blocCart: blocCart,
                index: widget.index,
                totalCount: widget.totalCount

            ),
          ),
        ),
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  final ScrollController scrollController;
  final Content content;
  final CartBloc blocCart;
  final int index;
  final int totalCount;

  const DesktopView({
    Key key,
    this.scrollController,
    this.content, this.blocCart, this.index, this.totalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddRemoveBloc bloc = BlocProvider.of<AddRemoveBloc>(context);
    return Container(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18.0),
                  height: 400,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(content.imageUrl),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        content.name,
                        style: TextStyle(fontSize: 30, color: Colors.red),
                      ),
                      Text(
                        content.description,
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 200, height: 50),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Small'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 200, height: 50),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Medium'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 200, height: 50),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Large'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                child: Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.black,
                                onPressed: () {
                                  blocCart.clear(index);
                                  bloc.add(AddRemoveEvent.decrement);
                                },
                              ),
                              BlocBuilder<AddRemoveBloc, int>(
                                builder: (context, count) {
                                  return Center(
                                    child: Text(
                                      totalCount.toString(),
                                      style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.white,
                                ),
                                color: Colors.red,
                                padding: EdgeInsets.zero,
                                iconSize: 42,
                                onPressed: () {
                                  blocCart.addToCart(index);
                                  bloc.add(AddRemoveEvent.increment);
                                },
                              ),
                            ],
                          ),
                          // BlocProvider(
                          //     create: (context) => AddRemoveBloc(0),
                          //     child: AddRemoveWidget()),
                          // ElevatedButton(onPressed: (){}, child: Text('Quantity'),style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: ConstrainedBox(
                constraints:
                BoxConstraints.tightFor(width: 300, height: 50),
                child: BlocBuilder<AddRemoveBloc, int>(
                  builder: (context, count) {
                    return ElevatedButton(
                      onPressed: () {
                        blocCart.addToCart(index);
                        Get.snackbar('Success', '$totalCount items bought');
                      },
                      child: Text('Add to cart'),
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MobileView extends StatelessWidget {
  final ScrollController scrollController;
  final Content content;
  final CartBloc blocCart;
  final int index;
  final int totalCount;


  const MobileView(
      {Key key, this.scrollController, this.content, this.blocCart, this.index, this.totalCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddRemoveBloc bloc = BlocProvider.of<AddRemoveBloc>(context);
    return Container(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 18.0),
                  height: 400,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(content.imageUrl),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      content.name,
                      style: TextStyle(fontSize: 30, color: Colors.red),
                    ),
                    Text(
                      content.description,
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 70, height: 35),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Small'),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 70, height: 35),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Medium'),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints.tightFor(
                                  width: 70, height: 35),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Large'),
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            'Clear',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                          onPressed: () {
                            blocCart.clear(index);
                            bloc.add(AddRemoveEvent.decrement);
                          },
                        ),
                        BlocBuilder<AddRemoveBloc, int>(
                          builder: (context, count) {
                            return Center(
                              child: Text(
                                totalCount.toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: Colors.white,
                          ),
                          color: Colors.red,
                          padding: EdgeInsets.zero,
                          iconSize: 42,
                          onPressed: () {
                            blocCart.addToCart(index);
                            bloc.add(AddRemoveEvent.increment);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
