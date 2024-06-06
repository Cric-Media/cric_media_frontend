import 'package:cricket_app/cubits/news/news_cubit.dart';
import 'package:cricket_app/custom_widgets/news_card.dart';
import 'package:cricket_app/custom_widgets/placeholders/news_placeholder.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:cricket_app/screens/dashbord_screen/news_details_screen.dart';
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
    if (NewsCubit.get(context).news.isEmpty) {
      NewsCubit.get(context).getNews();
    }
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              return ListView.builder(
                itemBuilder: (context, index) {
                  return const NewsPlaceholder();
                },
                itemCount: 6,
              );
            } else if (state is NewsGetErrorState) {
              return Center(child: Text(state.error));
            }
            return RefreshIndicator(
              onRefresh: () async {
                NewsCubit.get(context).getNews();
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (NewsCubit.get(context).news.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: NewsCubit.get(context).news.length +
                            1, // Add one for the "Load More" button
                        itemBuilder: (context, index) {
                          if (index < NewsCubit.get(context).news.length) {
                            var news = NewsCubit.get(context).news[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NewsDetailsScreen(news: news),
                                  ),
                                );
                              },
                              child: NewsCard(news: news),
                            );
                          } else {
                            return BlocBuilder<NewsCubit, NewsState>(
                              builder: (context, state) {
                                if (state is NewsGetMoreLoadingState) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                return ElevatedButton(
                                  onPressed: () {
                                    NewsCubit.get(context).getNews(more: true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Text("Load More"),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  const SizedBox(height: 70),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
