import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/AddRemoveBloc/AddRemoveBloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/CartBloc/cart_bloc.dart';
import 'package:flutter_netflix_responsive_ui/models/content_model.dart';
import 'package:flutter_netflix_responsive_ui/screen/selected_item_page.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../cubits/app_bar/app_bar_cubit.dart';

class ContentList extends StatelessWidget {
  final String title;
  final List<Content> contentList;
  final bool isOriginals;
  int totalCount;
  final CartBloc blocCart;

  ContentList({Key key,
    @required this.title,
    @required this.contentList,
    this.isOriginals = false, this.totalCount, this.blocCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Container(
            height: isOriginals ? 500.0 : 280.0,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,),
                itemCount: contentList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final Content content = contentList[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          print(content.name);
                          Get.to(ChangeNotifierProvider(
                              create: (context) => CartBloc(),
                              child: SelectedItemPage(content: content, index : index, totalCount: totalCount,)));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          height: isOriginals ? 400.0 : 200.0,
                          width: isOriginals ? 200.0 : 130.0,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(content.imageUrl),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      FlatButton(
                          onPressed: (){
                        blocCart.addToCart(index);
                      }, child: Text('Add', style: TextStyle(color: Colors.white),))
                    ],
                  );
                }
            ),
          ),


        ],
      ),
    );
  }
}
