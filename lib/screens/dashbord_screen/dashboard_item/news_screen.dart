import 'package:cricket_app/cubits/news/news_cubit.dart';
import 'package:cricket_app/custom_widgets/news_card.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:cricket_app/screens/dashbord_screen/new_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    NewsCubit.get(context).getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
      drawer: AppDrawer(screenWidth: screenWidth),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {
            if (state is NewsGetSuccessState) {
              NewsCubit.get(context).news = state.response.data;
            } else if (state is NewsGetMoreSuccessState) {
              NewsCubit.get(context).news.addAll(state.response.data);
            }
          },
          builder: (context, state) {
            if (state is NewsGetLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsGetErrorState) {
              return Center(child: Text(state.error));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 7),
                Expanded(
                  child: ListView.builder(
                    itemCount: NewsCubit.get(context).news.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var news = NewsCubit.get(context).news[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetails(news: news),
                                ),
                              );
                            },
                            child: NewsCard(news: news)),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 70),
              ],
            );
          },
        ),
      ),
    );
  }
}
