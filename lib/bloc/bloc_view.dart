import 'package:blocpatten/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data_repository.dart';
import 'home_cubit.dart';

class BlocView extends StatefulWidget {
  @override
  _BlocViewState createState() => _BlocViewState();
}

class _BlocViewState extends State<BlocView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(SampleHttpRepository()),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Demo Bloc Cubit App"),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return buildCenterInitialChild(context);
            } else if (state is HomeLoading) {
              return buildCenterLoading();
            } else if (state is HomeCompleted) {
              return buildListViewHome(state);
            } else {
              return buildError(state);
            }
          },
        ),
      );

  Text buildError(HomeState state) {
    final error = state as HomeError;
    return Text(error.message);
  }

  ListView buildListViewHome(HomeCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(state.response[index].title),
        subtitle: Text(state.response[index].body),
      ),
      // itemCount: state.response.length,
    );
  }

  Center buildCenterLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Center buildCenterInitialChild(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Push the button!"),
          SizedBox(height: 20,),
          buildFloatingActionButtonCall(context)
        ],
      ),
    );
  }

  FloatingActionButton buildFloatingActionButtonCall(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.sentiment_very_satisfied),
      onPressed: () {
        context.read<HomeCubit>().getData();
      },
    );
  }
}
