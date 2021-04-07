import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_netflix_responsive_ui/cubits/AddRemoveBloc/AddRemoveBloc.dart';

class AddRemoveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     AddRemoveBloc bloc = BlocProvider.of<AddRemoveBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove_circle, color: Colors.white,),
          color: Colors.red,
          iconSize: 42,
          onPressed: () => bloc.add(AddRemoveEvent.decrement),
        ),
        BlocBuilder<AddRemoveBloc, int>(
          builder: (context, count) {
            return Center(
              child: Text(
                '$count',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            );
          },
        ),
        SizedBox(width: 5,),
        IconButton(
          icon: Icon(Icons.add_circle, color: Colors.white,),
          color: Colors.red,
          padding: EdgeInsets.zero,
          iconSize: 42,
          onPressed: () => bloc.add(AddRemoveEvent.increment),
        ),
      ],
    );
  }
}
